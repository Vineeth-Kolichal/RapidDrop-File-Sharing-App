part of 'client_bloc.dart';

@freezed
sealed class ClientState with _$ClientState {
  const factory ClientState({
    required bool isLoading,
    String? error,
    ConnectionInfo? connectionInfo,
    List<RemoteFile>? fileList,
    double? uploadProgress,
    bool? isDarkMode,
    @Default(false) bool isWebSocketConnected,
  }) = _ClientState;

  factory ClientState.initial() => const ClientState(isLoading: false);
}
