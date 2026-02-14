import 'shared_file.dart';

class ServerInfo {
  final bool isRunning;
  final String? ipAddress;
  final int port;
  final String pin; // 4-digit PIN for authentication
  final List<SharedFile> sharedFiles;

  ServerInfo({
    required this.isRunning,
    this.ipAddress,
    required this.port,
    required this.pin,
    required this.sharedFiles,
  });

  String get serverUrl => 'http://$ipAddress:$port';
}
