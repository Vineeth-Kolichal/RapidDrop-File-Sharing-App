import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:file_sharing/core/base_usecase/base_usecase.dart';
import '../../domain/entities/server_info.dart';
import '../../domain/usecases/start_server_usecase.dart';
import '../../domain/usecases/stop_server_usecase.dart';
import '../../domain/usecases/get_server_info_usecase.dart';
import 'dart:async';
import '../../domain/usecases/add_file_usecase.dart';
import '../../domain/usecases/remove_file_usecase.dart';
import '../../domain/usecases/watch_shared_files_usecase.dart';
import '../../domain/entities/shared_file.dart';

part 'server_bloc.freezed.dart';
part 'server_event.dart';
part 'server_state.dart';

@injectable
class ServerBloc extends Bloc<ServerEvent, ServerState> {
  final StartServerUseCase startServerUseCase;
  final StopServerUseCase stopServerUseCase;
  final GetServerInfoUseCase getServerInfoUseCase;
  final AddFileUseCase addFileUseCase;
  final RemoveFileUseCase removeFileUseCase;
  final WatchSharedFilesUseCase watchSharedFilesUseCase;
  StreamSubscription<List<SharedFile>>? _filesSubscription;

  ServerBloc(
    this.startServerUseCase,
    this.stopServerUseCase,
    this.getServerInfoUseCase,
    this.addFileUseCase,
    this.removeFileUseCase,
    this.watchSharedFilesUseCase,
  ) : super(ServerState.initial()) {
    on<StartServer>(_onStartServer);
    on<StopServer>(_onStopServer);
    on<AddFile>(_onAddFile);
    on<RemoveFile>(_onRemoveFile);
    on<GetServerInfo>(_onGetServerInfo);
    on<SharedFilesUpdated>(_onSharedFilesUpdated);
  }

  @override
  Future<void> close() {
    _filesSubscription?.cancel();
    return super.close();
  }

  Future<void> _onStartServer(
    StartServer event,
    Emitter<ServerState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await startServerUseCase(NoParams());

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.toString())),
      (serverInfo) {
        emit(
          state.copyWith(isLoading: false, serverInfo: serverInfo, error: null),
        );
        _filesSubscription?.cancel();
        _filesSubscription = watchSharedFilesUseCase().listen((files) {
          add(ServerEvent.sharedFilesUpdated(files));
        });
      },
    );
  }

  Future<void> _onStopServer(
    StopServer event,
    Emitter<ServerState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await stopServerUseCase(NoParams());

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.toString())),
      (_) {
        _filesSubscription?.cancel();
        emit(state.copyWith(isLoading: false, serverInfo: null, error: null));
      },
    );
  }

  void _onSharedFilesUpdated(
    SharedFilesUpdated event,
    Emitter<ServerState> emit,
  ) {
    if (state.serverInfo != null) {
      emit(
        state.copyWith(
          serverInfo: state.serverInfo!.copyWith(sharedFiles: event.files),
        ),
      );
    }
  }

  Future<void> _onAddFile(AddFile event, Emitter<ServerState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await addFileUseCase(
      AddFileParams(filePath: event.filePath),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.toString())),
      (_) async {
        // No need to manually refresh - stream will handle it
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  Future<void> _onRemoveFile(
    RemoveFile event,
    Emitter<ServerState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await removeFileUseCase(
      RemoveFileParams(filename: event.filename),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.toString())),
      (_) async {
        // No need to manually refresh - stream will handle it
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  Future<void> _onGetServerInfo(
    GetServerInfo event,
    Emitter<ServerState> emit,
  ) async {
    final result = await getServerInfoUseCase(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(error: failure.toString())),
      (serverInfo) => emit(state.copyWith(serverInfo: serverInfo)),
    );
  }
}
