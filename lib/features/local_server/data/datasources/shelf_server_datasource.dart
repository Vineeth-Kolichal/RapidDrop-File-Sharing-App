import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/shared_file_model.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@LazySingleton()
@injectable
class ShelfServerDataSource {
  HttpServer? _server;
  final List<SharedFileModel> _sharedFiles = [];
  String? _ipAddress;
  String? _pin; // 4-digit PIN for authentication
  final Set<String> _validSessions = {}; // Active session tokens
  final List<WebSocketChannel> _clients = []; // Connected WebSocket clients
  static const int _port = 8080;

  final _filesController = StreamController<List<SharedFileModel>>.broadcast();
  Stream<List<SharedFileModel>> get filesStream => _filesController.stream;

  Future<Map<String, dynamic>> startServer() async {
    try {
      // Get WiFi IP address
      final networkInfo = NetworkInfo();
      _ipAddress = await networkInfo.getWifiIP();

      if (_ipAddress == null) {
        throw Exception(
          'Unable to get WiFi IP address. Please ensure WiFi is connected.',
        );
      }

      // Generate random 4-digit PIN
      _pin = (1000 + (DateTime.now().microsecondsSinceEpoch % 9000)).toString();
      _validSessions.clear(); // Clear any existing sessions
      print('Server PIN: $_pin');

      // Create router
      final router = Router();

      // Serve embedded web UI - Root path
      router.get('/', (Request request) => _serveWebAsset('index.html'));

      // WebSocket endpoint
      router.get(
        '/ws',
        webSocketHandler((WebSocketChannel channel, String? protocol) {
          _clients.add(channel);
          print(
            'WebSocket client connected. Total clients: ${_clients.length}',
          );

          channel.stream.listen(
            (message) {
              print('Received WS message: $message');
              try {
                final data = json.decode(message);
                if (data['type'] == 'theme_sync') {
                  final isDarkMode = data['isDarkMode'] as bool;
                  _handleThemeSync(isDarkMode, source: channel);
                }
              } catch (e) {
                print('Error partins WS message: $e');
              }
            },
            onDone: () {
              _clients.remove(channel);
              print(
                'WebSocket client disconnected. Total clients: ${_clients.length}',
              );
            },
            onError: (error) {
              _clients.remove(channel);
              print('WebSocket error: $error');
            },
          );
        }),
      );

      // API: POST /api/validate-pin - Validate PIN and issue session token
      router.post('/api/validate-pin', (Request request) async {
        try {
          final body = await request.readAsString();
          final data = json.decode(body) as Map<String, dynamic>;
          final pin = data['pin'] as String?;

          if (pin == null || pin.isEmpty) {
            return Response.badRequest(
              body: json.encode({'error': 'PIN is required'}),
            );
          }

          if (pin == _pin) {
            // Generate session token
            final sessionToken =
                DateTime.now().microsecondsSinceEpoch.toString() +
                (DateTime.now().millisecondsSinceEpoch % 10000).toString();
            _validSessions.add(sessionToken);

            return Response.ok(
              json.encode({
                'success': true,
                'sessionToken': sessionToken,
                'message': 'PIN validated successfully',
                'wsUrl': 'ws://$_ipAddress:$_port/ws',
              }),
              headers: {'Content-Type': 'application/json'},
            );
          } else {
            return Response(
              403,
              body: json.encode({'error': 'Invalid PIN'}),
              headers: {'Content-Type': 'application/json'},
            );
          }
        } catch (e) {
          return Response.internalServerError(
            body: json.encode({'error': 'Validation failed: $e'}),
          );
        }
      });

      // API: GET /api/files - List all available files
      router.get('/api/files', (Request request) {
        final filesList = _sharedFiles.map((file) {
          return {
            'name': file.name,
            'size': file.size,
            'mimeType': file.mimeType,
            'addedAt': file.addedAt.toIso8601String(),
            'isUploaded': file.isUploaded,
          };
        }).toList();

        return Response.ok(
          json.encode({'files': filesList}),
          headers: {'Content-Type': 'application/json'},
        );
      });

      // GET /download/:filename - Download a specific file (streaming for large files)
      router.get('/download/<filename>', (
        Request request,
        String filename,
      ) async {
        try {
          // Decode URL-encoded filename (handles spaces, special characters, etc.)
          // e.g., "My%20Video%20%282024%29.mp4" → "My Video (2024).mp4"
          final decodedFilename = Uri.decodeComponent(filename);

          final file = _sharedFiles.firstWhere(
            (f) => f.name == decodedFilename,
            orElse: () => throw Exception('File not found'),
          );

          final fileObj = File(file.path);
          if (!await fileObj.exists()) {
            return Response.notFound('File not found on server');
          }

          // Stream the file instead of loading entire file into memory
          // This is crucial for large files (3GB+ videos)
          final fileStream = fileObj.openRead();
          final fileSize = await fileObj.length();

          return Response.ok(
            fileStream,
            headers: {
              'Content-Type': file.mimeType,
              'Content-Disposition': 'attachment; filename="${file.name}"',
              'Content-Length': '$fileSize',
              'Accept-Ranges': 'bytes',
            },
          );
        } catch (e) {
          return Response.notFound('File not found: $e');
        }
      });

      // DELETE /api/files/<filename>
      router.delete('/api/files/<filename>', (
        Request request,
        String filename,
      ) async {
        try {
          final decodedFilename = Uri.decodeComponent(filename);
          final fileModel = _sharedFiles.firstWhere(
            (f) => f.name == decodedFilename,
            orElse: () => throw Exception('File not found'),
          );

          if (fileModel.isUploaded) {
            final file = File(fileModel.path);
            if (await file.exists()) {
              await file.delete();
            }
          }

          _sharedFiles.remove(fileModel);
          _filesController.add(List.from(_sharedFiles));
          _notifyClients();

          return Response.ok(
            json.encode({'success': true, 'message': 'File deleted'}),
            headers: {'Content-Type': 'application/json'},
          );
        } catch (e) {
          return Response.internalServerError(
            body: 'Failed to delete file: $e',
          );
        }
      });

      // POST /upload - Receive file upload with multipart form data
      router.post('/upload', (Request request) async {
        try {
          // Check if it's multipart form data
          final contentType = request.headers['content-type'];
          if (contentType == null ||
              !contentType.contains('multipart/form-data')) {
            return Response.badRequest(body: 'Expected multipart/form-data');
          }

          // Parse multipart form data
          final boundary = contentType.split('boundary=').last;
          final transformer = MimeMultipartTransformer(boundary);
          final bodyStream = request.read();
          final parts = await transformer.bind(bodyStream).toList();

          String? uploadedFilename;
          List<int>? fileBytes;

          // Process each part
          for (final part in parts) {
            final contentDisposition = part.headers['content-disposition'];
            if (contentDisposition != null &&
                contentDisposition.contains('filename=')) {
              // Extract filename from content-disposition header
              final fileNameMatch = RegExp(
                r'filename="([^"]+)"',
              ).firstMatch(contentDisposition);
              if (fileNameMatch != null) {
                uploadedFilename = fileNameMatch.group(1);
              }

              // Read file bytes
              final chunks = await part.toList();
              fileBytes = chunks.fold<List<int>>(
                [],
                (previous, element) => previous..addAll(element),
              );
            }
          }

          if (uploadedFilename == null || fileBytes == null) {
            return Response.badRequest(body: 'No file found in upload');
          }

          // Save file with original filename
          final directory = await getApplicationDocumentsDirectory();
          var finalFilename = uploadedFilename;
          var finalFilePath = '${directory.path}/$finalFilename';

          // Handle duplicate filenames
          var counter = 1;
          while (await File(finalFilePath).exists()) {
            final extension = uploadedFilename.contains('.')
                ? uploadedFilename.substring(uploadedFilename.lastIndexOf('.'))
                : '';
            final nameWithoutExt = uploadedFilename.contains('.')
                ? uploadedFilename.substring(
                    0,
                    uploadedFilename.lastIndexOf('.'),
                  )
                : uploadedFilename;
            finalFilename = '${nameWithoutExt}_$counter$extension';
            finalFilePath = '${directory.path}/$finalFilename';
            counter++;
          }

          await File(finalFilePath).writeAsBytes(fileBytes);

          final mimeType =
              lookupMimeType(finalFilename) ?? 'application/octet-stream';
          final fileModel = SharedFileModel(
            name: finalFilename,
            path: finalFilePath,
            size: fileBytes.length,
            mimeType: mimeType,
            addedAt: DateTime.now(),
            isUploaded: true,
          );

          _sharedFiles.add(fileModel);
          _filesController.add(List.from(_sharedFiles));
          _notifyClients();
          print(
            'File uploaded successfully: $finalFilename (${(fileBytes.length / 1024 / 1024).toStringAsFixed(2)} MB)',
          );

          return Response.ok(
            json.encode({
              'message': 'File uploaded successfully',
              'filename': finalFilename,
            }),
            headers: {'Content-Type': 'application/json'},
          );
        } catch (e, stackTrace) {
          print('Upload error: $e');
          print('Stack trace: $stackTrace');
          return Response.internalServerError(body: 'Upload failed: $e');
        }
      });

      // Serve static web assets - Catch-all route must be last
      router.get('/<path|.*>', (Request request, String path) async {
        // Only serve web UI assets, not API endpoints
        // This check is still useful to return 404 for unknown /api/ paths
        if (path.startsWith('api/') ||
            path.startsWith('files') ||
            path.startsWith('download') ||
            path.startsWith('upload')) {
          return Response.notFound('Not found');
        }
        return _serveWebAsset(path);
      });

      // Add middleware for CORS
      final handler = Pipeline()
          .addMiddleware(_corsMiddleware())
          .addMiddleware(logRequests())
          .addHandler(router.call);

      // Start the server
      _server = await shelf_io.serve(handler, _ipAddress!, _port);
      // Server is now running

      return {
        'isRunning': true,
        'ipAddress': _ipAddress,
        'port': _port,
        'pin': _pin ?? '',
        'sharedFiles': _sharedFiles,
      };
    } catch (e) {
      rethrow;
    }
  }

  Future<void> stopServer() async {
    await _server?.close(force: true);
    _server = null;
    _pin = null;
    _server = null;
    _pin = null;
    _validSessions.clear();
    for (final client in _clients) {
      client.sink.close();
    }
    _clients.clear();
  }

  Map<String, dynamic> getServerInfo() {
    return {
      'isRunning': _server != null,
      'ipAddress': _ipAddress,
      'port': _port,
      'pin': _pin ?? '',
      'sharedFiles': _sharedFiles,
    };
  }

  Future<void> addFile(String filePath) async {
    try {
      // Log the file path we're trying to add
      print('Attempting to add file: $filePath');

      final file = File(filePath);

      // Check if file exists
      final exists = await file.exists();
      print('File exists: $exists');

      if (!exists) {
        throw Exception('File does not exist at path: $filePath');
      }

      // Try to get file stats (this doesn't load the file into memory)
      final stat = await file.stat();
      print('File size: ${(stat.size / 1024 / 1024).toStringAsFixed(2)} MB');

      final filename = file.path.split('/').last;
      print('Filename: $filename');

      final mimeType = lookupMimeType(filename) ?? 'application/octet-stream';
      print('MIME type: $mimeType');

      final fileModel = SharedFileModel(
        name: filename,
        path: filePath,
        size: stat.size,
        mimeType: mimeType,
        addedAt: DateTime.now(),
      );

      _sharedFiles.add(fileModel);
      _filesController.add(List.from(_sharedFiles));
      _notifyClients();
      print('Successfully added file to shared list');
    } catch (e, stackTrace) {
      print('Error adding file: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> removeFile(String filename) async {
    final fileModel = _sharedFiles.firstWhere(
      (f) => f.name == filename,
      orElse: () => throw Exception('File not found'),
    );

    if (fileModel.isUploaded) {
      final file = File(fileModel.path);
      if (await file.exists()) {
        await file.delete();
      }
    }

    _sharedFiles.remove(fileModel);
    _filesController.add(List.from(_sharedFiles));
    _notifyClients();
  }

  void _notifyClients() {
    print('Notifying ${_clients.length} clients of update');
    for (final client in _clients) {
      client.sink.add(json.encode({'type': 'refresh'}));
    }
  }

  void broadcastThemeChange(bool isDarkMode) {
    _handleThemeSync(isDarkMode, source: null);
  }

  void _handleThemeSync(bool isDarkMode, {WebSocketChannel? source}) {
    print('Broadcasting theme change: isDark=$isDarkMode');
    final message = json.encode({
      'type': 'theme_sync',
      'isDarkMode': isDarkMode,
    });

    for (final client in _clients) {
      if (client != source) {
        client.sink.add(message);
      }
    }
  }

  // CORS middleware
  Middleware _corsMiddleware() {
    return (Handler handler) {
      return (Request request) async {
        if (request.method == 'OPTIONS') {
          return Response.ok('', headers: _corsHeaders);
        }

        final response = await handler(request);
        return response.change(headers: _corsHeaders);
      };
    };
  }

  final Map<String, String> _corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, Content-Type, Accept',
  };

  // Serve static web assets from Android assets
  Future<Response> _serveWebAsset(String path) async {
    try {
      // Read asset from bundle
      final assetPath = 'android/app/src/main/assets/web/$path';
      final bytes = await rootBundle.load(assetPath);
      final data = bytes.buffer.asUint8List();

      // Determine MIME type based on file extension
      final mimeType = _getMimeType(path);

      return Response.ok(
        data,
        headers: {
          'Content-Type': mimeType,
          'Cache-Control': 'public, max-age=3600',
        },
      );
    } catch (e) {
      print('Error serving web asset $path: $e');
      return Response.notFound('Asset not found: $path');
    }
  }

  // Get MIME type for web assets
  String _getMimeType(String path) {
    if (path.endsWith('.html')) return 'text/html';
    if (path.endsWith('.js')) return 'application/javascript';
    if (path.endsWith('.css')) return 'text/css';
    if (path.endsWith('.json')) return 'application/json';
    if (path.endsWith('.png')) return 'image/png';
    if (path.endsWith('.jpg') || path.endsWith('.jpeg')) return 'image/jpeg';
    if (path.endsWith('.svg')) return 'image/svg+xml';
    if (path.endsWith('.woff')) return 'font/woff';
    if (path.endsWith('.woff2')) return 'font/woff2';
    if (path.endsWith('.ttf')) return 'font/ttf';
    if (path.endsWith('.otf')) return 'font/otf';
    if (path.endsWith('.wasm')) return 'application/wasm';
    if (path.endsWith('.ico')) return 'image/x-icon';
    return 'application/octet-stream';
  }
}
