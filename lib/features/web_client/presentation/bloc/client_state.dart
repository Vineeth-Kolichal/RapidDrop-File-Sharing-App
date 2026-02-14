part of 'client_bloc.dart';

@freezed
sealed class ClientState with _$ClientState {
  const factory ClientState({
    required bool isLoading,
    String? error,
    ConnectionInfo? connectionInfo,
    List<RemoteFile>? fileList,
  }) = _ClientState;

  factory ClientState.initial() => const ClientState(isLoading: false);
}
