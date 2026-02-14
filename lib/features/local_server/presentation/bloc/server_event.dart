part of 'server_bloc.dart';

@freezed
class ServerEvent with _$ServerEvent {
  const factory ServerEvent.startServer() = StartServer;
  const factory ServerEvent.stopServer() = StopServer;
  const factory ServerEvent.addFile(String filePath) = AddFile;
  const factory ServerEvent.removeFile(String filename) = RemoveFile;
  const factory ServerEvent.getServerInfo() = GetServerInfo;
  const factory ServerEvent.sharedFilesUpdated(List<SharedFile> files) =
      SharedFilesUpdated;
}
