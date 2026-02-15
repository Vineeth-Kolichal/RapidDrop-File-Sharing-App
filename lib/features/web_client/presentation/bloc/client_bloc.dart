import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:file_sharing/core/base_usecase/base_usecase.dart';
import '../../domain/entities/connection_info.dart';
import '../../domain/entities/file_entity.dart';
import '../../domain/entities/remote_file.dart';
import '../../domain/usecases/connect_to_server_usecase.dart';
import '../../domain/usecases/get_file_list_usecase.dart';
import '../../domain/usecases/upload_file_usecase.dart';
import '../../domain/usecases/validate_pin_usecase.dart';

import '../../domain/usecases/delete_file_usecase.dart';
import '../../domain/usecases/listen_to_notifications_usecase.dart';
import 'dart:convert';

part 'client_bloc.freezed.dart';
part 'client_event.dart';
part 'client_state.dart';

@injectable
class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ConnectToServerUseCase connectToServerUseCase;
  final GetFileListUseCase getFileListUseCase;
  final UploadFileUseCase uploadFileUseCase;
  final ValidatePinUseCase validatePinUseCase;
  final DeleteFileUseCase deleteFileUseCase;
  final ListenToNotificationsUseCase listenToNotificationsUseCase;

  StreamSubscription? _notificationSubscription;

  ClientBloc(
    this.connectToServerUseCase,
    this.getFileListUseCase,
    this.uploadFileUseCase,
    this.validatePinUseCase,
    this.deleteFileUseCase,
    this.listenToNotificationsUseCase,
  ) : super(ClientState.initial()) {
    on<Connect>(_onConnect);
    on<ValidatePin>(_onValidatePin);
    on<Disconnect>(_onDisconnect);
    on<FetchFiles>(_onFetchFiles);
    on<UploadFile>(_onUploadFile);
    on<DeleteFile>(_onDeleteFile);
    on<StartAutoRefresh>(_onStartAutoRefresh);
    on<StopAutoRefresh>(_onStopAutoRefresh);
    on<_UpdateUploadProgress>(_onUpdateUploadProgress);
    on<_NotificationReceived>(_onNotificationReceived);
    on<_ThemeChanged>(_onThemeChanged);
  }

  void _onThemeChanged(_ThemeChanged event, Emitter<ClientState> emit) {
    emit(state.copyWith(isDarkMode: event.isDark));
  }

  void _onUpdateUploadProgress(
    _UpdateUploadProgress event,
    Emitter<ClientState> emit,
  ) {
    emit(state.copyWith(uploadProgress: event.progress));
  }

  void _onNotificationReceived(
    _NotificationReceived event,
    Emitter<ClientState> emit,
  ) {
    add(const ClientEvent.fetchFiles(silent: true));
  }

  Future<void> _onValidatePin(
    ValidatePin event,
    Emitter<ClientState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await validatePinUseCase(ValidatePinParams(pin: event.pin));

    await result.fold(
      (failure) async =>
          emit(state.copyWith(isLoading: false, error: failure.error)),
      (connectionInfo) async {
        emit(
          state.copyWith(
            isLoading: false,
            connectionInfo: connectionInfo,
            error: null,
          ),
        );

        // Auto-fetch files after successful validation
        add(const ClientEvent.fetchFiles());

        // Start auto-refresh
        add(const ClientEvent.startAutoRefresh());
      },
    );
  }

  Future<void> _onConnect(Connect event, Emitter<ClientState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await connectToServerUseCase(
      ConnectParams(ip: event.ip, port: event.port),
    );

    await result.fold(
      (failure) async =>
          emit(state.copyWith(isLoading: false, error: failure.error)),
      (connectionInfo) async {
        emit(
          state.copyWith(
            isLoading: false,
            connectionInfo: connectionInfo,
            error: null,
          ),
        );

        // Auto-fetch files after successful connection
        add(const ClientEvent.fetchFiles());

        // Start auto-refresh
        add(const ClientEvent.startAutoRefresh());
      },
    );
  }

  Future<void> _onDisconnect(
    Disconnect event,
    Emitter<ClientState> emit,
  ) async {
    add(const ClientEvent.stopAutoRefresh());
    emit(ClientState.initial());
  }

  Future<void> _onFetchFiles(
    FetchFiles event,
    Emitter<ClientState> emit,
  ) async {
    if (state.connectionInfo == null || !state.connectionInfo!.isConnected) {
      emit(state.copyWith(error: 'Not connected to any server'));
      return;
    }

    // Don't show loading spinner during auto-refresh
    if (!event.silent) {
      emit(state.copyWith(isLoading: true));
    }

    final result = await getFileListUseCase(NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          error: event.silent ? null : failure.error,
        ),
      ),
      (fileList) => emit(
        state.copyWith(isLoading: false, fileList: fileList, error: null),
      ),
    );
  }

  Future<void> _onUploadFile(
    UploadFile event,
    Emitter<ClientState> emit,
  ) async {
    if (state.connectionInfo == null || !state.connectionInfo!.isConnected) {
      emit(state.copyWith(error: 'Not connected to any server'));
      return;
    }

    emit(state.copyWith(isLoading: true, uploadProgress: 0.0));

    final result = await uploadFileUseCase(
      UploadFileParams(
        file: event.file,
        onSendProgress: (sent, total) {
          add(ClientEvent.updateUploadProgress(sent / total));
        },
      ),
    );

    await result.fold(
      (failure) async =>
          emit(state.copyWith(isLoading: false, error: failure.error)),
      (_) async {
        emit(state.copyWith(isLoading: false, uploadProgress: null));
        // Refresh file list after upload
        add(const ClientEvent.fetchFiles());
      },
    );
  }

  Future<void> _onDeleteFile(
    DeleteFile event,
    Emitter<ClientState> emit,
  ) async {
    if (state.connectionInfo == null || !state.connectionInfo!.isConnected) {
      emit(state.copyWith(error: 'Not connected to any server'));
      return;
    }

    emit(state.copyWith(isLoading: true));

    final result = await deleteFileUseCase(
      DeleteFileParams(filename: event.filename),
    );

    await result.fold(
      (failure) async =>
          emit(state.copyWith(isLoading: false, error: failure.error)),
      (_) async {
        emit(state.copyWith(isLoading: false));
        // Refresh file list after deletion
        add(const ClientEvent.fetchFiles());
      },
    );
  }

  Future<void> _onStartAutoRefresh(
    StartAutoRefresh event,
    Emitter<ClientState> emit,
  ) async {
    await _notificationSubscription?.cancel();
    _notificationSubscription = listenToNotificationsUseCase().listen((
      message,
    ) {
      if (message is String) {
        try {
          final data = json.decode(message);
          if (data['type'] == 'theme_sync') {
            add(ClientEvent.themeChanged(data['isDarkMode'] as bool));
          } else {
            add(const ClientEvent.notificationReceived());
          }
        } catch (e) {
          // Fallback for simple string messages or other formats
          add(const ClientEvent.notificationReceived());
        }
      } else {
        add(const ClientEvent.notificationReceived());
      }
    });
  }

  void _onStopAutoRefresh(StopAutoRefresh event, Emitter<ClientState> emit) {
    _notificationSubscription?.cancel();
    _notificationSubscription = null;
  }

  @override
  Future<void> close() {
    _notificationSubscription?.cancel();
    return super.close();
  }
}
