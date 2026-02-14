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

  ServerInfo copyWith({
    bool? isRunning,
    String? ipAddress,
    int? port,
    String? pin,
    List<SharedFile>? sharedFiles,
  }) {
    return ServerInfo(
      isRunning: isRunning ?? this.isRunning,
      ipAddress: ipAddress ?? this.ipAddress,
      port: port ?? this.port,
      pin: pin ?? this.pin,
      sharedFiles: sharedFiles ?? this.sharedFiles,
    );
  }

  String get serverUrl => 'http://$ipAddress:$port';
}
