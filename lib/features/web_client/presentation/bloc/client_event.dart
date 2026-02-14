part of 'client_bloc.dart';

@freezed
class ClientEvent with _$ClientEvent {
  const factory ClientEvent.connect(String ip, int port) = Connect;
  const factory ClientEvent.validatePin(String pin) = ValidatePin;
  const factory ClientEvent.disconnect() = Disconnect;
  const factory ClientEvent.fetchFiles({@Default(false) bool silent}) =
      FetchFiles;
  const factory ClientEvent.uploadFile(FileEntity file) = UploadFile;
  const factory ClientEvent.deleteFile(String filename) = DeleteFile;
  const factory ClientEvent.startAutoRefresh() = StartAutoRefresh;
  const factory ClientEvent.stopAutoRefresh() = StopAutoRefresh;
  const factory ClientEvent.notificationReceived() = _NotificationReceived;
}
