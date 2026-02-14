import 'dart:async';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:file_sharing/core/api_endpoints/api_endpoints.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../domain/entities/file_entity.dart';
import '../models/remote_file_model.dart';

@LazySingleton()
@injectable
class RemoteServerDataSource {
  final Dio _dio;
  String? _baseUrl;
  WebSocketChannel? _channel;
  final _notificationsController = StreamController<void>.broadcast();
  Stream<void> get notifications => _notificationsController.stream;

  RemoteServerDataSource(this._dio);

  void setBaseUrl(String ip, int port) {
    _baseUrl = 'http://$ip:$port';
  }

  Future<String> validatePin(String pin) async {
    // For embedded web UI, auto-detect server URL
    _baseUrl = ''; // Will use relative URLs since we're on the same origin

    try {
      final response = await _dio.post('/api/validate-pin', data: {'pin': pin});

      final sessionToken = response.data['sessionToken'] as String;

      // Store session token for future requests
      _dio.options.headers['Authorization'] = 'Bearer $sessionToken';

      // Store session token for future requests
      _dio.options.headers['Authorization'] = 'Bearer $sessionToken';

      // Connect to WebSocket
      final wsUrl = response.data['wsUrl'] as String?;
      await connectWebSocket(pin: pin, url: wsUrl);

      return sessionToken;
    } catch (e) {
      _baseUrl = null;
      rethrow;
    }
  }

  Future<void> connectWebSocket({String? pin, String? url}) async {
    try {
      Uri wsUri;
      if (url != null && url.isNotEmpty) {
        wsUri = Uri.parse(url);
      } else if (_baseUrl != null && _baseUrl!.isNotEmpty) {
        final uri = Uri.parse(_baseUrl!);
        wsUri = uri.replace(scheme: 'ws', path: '/ws');
      } else {
        print('WebSocket URL could not be determined');
        return;
      }

      print('Connecting to WebSocket: $wsUri');
      _channel = WebSocketChannel.connect(wsUri);

      _channel!.stream.listen(
        (message) {
          print('WS Message: $message');
          if (message != null) {
            // For now, any message triggers a refresh
            _notificationsController.add(null);
          }
        },
        onError: (e) => print('WS Error: $e'),
        onDone: () => print('WS Disconnected'),
      );
    } catch (e) {
      print('WebSocket connection failed: $e');
    }
  }

  Future<void> testConnection() async {
    if (_baseUrl == null) {
      throw Exception('Base URL not set. Call setBaseUrl first.');
    }

    try {
      await _dio.get('$_baseUrl${ApiEndpoints.files}');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RemoteFileModel>> getFileList() async {
    if (_baseUrl == null) {
      throw Exception('Not connected to any server');
    }

    try {
      final response = await _dio.get('$_baseUrl${ApiEndpoints.files}');

      final List<dynamic> filesJson = response.data['files'] ?? [];
      return filesJson
          .map((json) => RemoteFileModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> downloadFile(String filename, String savePath) async {
    if (_baseUrl == null) {
      throw Exception('Not connected to any server');
    }

    try {
      await _dio.download(
        '$_baseUrl${ApiEndpoints.download(filename)}',
        savePath,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadFile(FileEntity file) async {
    if (_baseUrl == null) {
      throw Exception('Not connected to any server');
    }

    try {
      final formData = FormData();

      if (file.bytes != null) {
        // Web upload using bytes
        formData.files.add(
          MapEntry(
            'file',
            MultipartFile.fromBytes(file.bytes!, filename: file.name),
          ),
        );
      } else if (file.path != null) {
        // Mobile/Desktop upload using path
        formData.files.add(
          MapEntry(
            'file',
            await MultipartFile.fromFile(file.path!, filename: file.name),
          ),
        );
      } else {
        throw Exception('No file data provided');
      }

      await _dio.post('$_baseUrl${ApiEndpoints.upload}', data: formData);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFile(String filename) async {
    if (_baseUrl == null) {
      throw Exception('Not connected to any server');
    }

    try {
      final encodedFilename = Uri.encodeComponent(filename);
      await _dio.delete('$_baseUrl${ApiEndpoints.files}/$encodedFilename');
    } catch (e) {
      rethrow;
    }
  }

  void disconnect() {
    _baseUrl = null;
    _channel?.sink.close();
    _channel = null;
  }

  bool get isConnected => _baseUrl != null;
}
