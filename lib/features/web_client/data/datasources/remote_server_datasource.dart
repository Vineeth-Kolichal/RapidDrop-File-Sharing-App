import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:file_sharing/core/api_endpoints/api_endpoints.dart';
import '../models/remote_file_model.dart';

@LazySingleton()
@injectable
class RemoteServerDataSource {
  final Dio _dio;
  String? _baseUrl;

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

      return sessionToken;
    } catch (e) {
      _baseUrl = null;
      rethrow;
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

  Future<void> uploadFile(String filePath) async {
    if (_baseUrl == null) {
      throw Exception('Not connected to any server');
    }

    try {
      final file = File(filePath);
      final filename = file.path.split('/').last;

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath, filename: filename),
      });

      await _dio.post('$_baseUrl${ApiEndpoints.upload}', data: formData);
    } catch (e) {
      rethrow;
    }
  }

  void disconnect() {
    _baseUrl = null;
  }

  bool get isConnected => _baseUrl != null;
}
