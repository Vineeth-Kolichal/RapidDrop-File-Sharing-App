part of 'server_bloc.dart';

@freezed
sealed class ServerState with _$ServerState {
  const factory ServerState({
    required bool isLoading,
    String? error,
    ServerInfo? serverInfo,
  }) = _ServerState;

  factory ServerState.initial() => const ServerState(isLoading: false);
}
