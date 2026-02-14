class ConnectionInfo {
  final bool isConnected;
  final String? serverIp;
  final int? port;

  ConnectionInfo({required this.isConnected, this.serverIp, this.port});

  String? get serverUrl => isConnected ? 'http://$serverIp:$port' : null;
}
