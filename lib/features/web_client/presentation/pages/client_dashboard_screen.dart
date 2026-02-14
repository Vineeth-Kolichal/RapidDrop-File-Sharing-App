import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_sharing/core/extensions/theme_ext.dart';
import 'package:universal_html/html.dart' as html;
import 'package:file_sharing/features/web_client/domain/entities/file_entity.dart';
import '../bloc/client_bloc.dart';

class ClientDashboardScreen extends StatefulWidget {
  const ClientDashboardScreen({super.key});

  @override
  State<ClientDashboardScreen> createState() => _ClientDashboardScreenState();
}

class _ClientDashboardScreenState extends State<ClientDashboardScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Auto-detect server URL when web UI loads (using window.location.origin)
    // Session handling will be done in the datasource layer
  }

  Future<void> _uploadFile() async {
    // Ensure we pick with data for Web/Desktop if needed
    final result = await FilePicker.platform.pickFiles(withData: true);

    if (result != null && result.files.isNotEmpty) {
      final pickedFile = result.files.single;

      // On Web, path is null, use bytes.
      // On Mobile, path is available (bytes might be null if not requested, but we requested withData=true so bytes should be there too,
      // but strictly speaking we should prefer path on mobile to avoid loading large files into memory if possible.
      // However, `withData: true` loads into memory.
      // For large files on mobile, better to use `withData: false` and use path.
      // But for Web we MUST use bytes/readStream.
      // Let's refine:

      FileEntity fileEntity;
      if (kIsWeb) {
        if (pickedFile.bytes != null) {
          fileEntity = FileEntity(
            name: pickedFile.name,
            bytes: pickedFile.bytes,
          );
        } else {
          // Fallback or error
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to load file data')),
            );
          }
          return;
        }
      } else {
        // Mobile/Desktop
        if (pickedFile.path != null) {
          fileEntity = FileEntity(name: pickedFile.name, path: pickedFile.path);
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to get file path')),
            );
          }
          return;
        }
      }

      if (mounted) {
        context.read<ClientBloc>().add(ClientEvent.uploadFile(fileEntity));
      }
    }
  }

  Future<void> _downloadFile(String filename, String serverUrl) async {
    if (!kIsWeb) {
      // For mobile platforms, would need different implementation
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Download only supported on web')),
        );
      }
      return;
    }

    try {
      // Web-specific download using anchor element
      final downloadUrl = '$serverUrl/download/$filename';
      final anchor = html.AnchorElement(href: downloadUrl)
        ..setAttribute('download', filename)
        ..style.display = 'none';

      anchor.click();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Download failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Scaffold(
      backgroundColor: appColors?.surfaceColor,
      appBar: AppBar(title: const Text('File Sharing Client')),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: BlocBuilder<ClientBloc, ClientState>(
            builder: (context, state) {
              // Disconnected State - Show PIN entry form
              if (state.connectionInfo == null ||
                  !state.connectionInfo!.isConnected) {
                return Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    padding: const EdgeInsets.all(24),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.lock_outline,
                              size: 64,
                              color: appColors?.primary,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Enter Access PIN',
                              style: context.titleLarge(),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Enter the 4-digit PIN shown on the host device.',
                              style: context.bodyMedium(),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            TextField(
                              controller: _pinController,
                              decoration: InputDecoration(
                                labelText: 'PIN',
                                hintText: '0000',
                                prefixIcon: const Icon(Icons.pin),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                letterSpacing: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (state.error != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Text(
                                  state.error!,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: state.isLoading
                                    ? null
                                    : () {
                                        final pin = _pinController.text.trim();
                                        if (pin.isNotEmpty && pin.length == 4) {
                                          context.read<ClientBloc>().add(
                                            ClientEvent.validatePin(pin),
                                          );
                                        }
                                      },
                                icon: state.isLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Icon(Icons.lock_open),
                                label: Text(
                                  state.isLoading ? 'Validating...' : 'Connect',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }

              // Connected State - Show file list
              final connectionInfo = state.connectionInfo!;
              final fileList = state.fileList ?? [];

              return Column(
                children: [
                  // Connection Header
                  Container(
                    color: appColors?.primary?.withValues(alpha: 0.1),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Connected to', style: context.bodySmall()),
                            Text(
                              connectionInfo.serverUrl ?? '',
                              style: context.bodyMedium()?.copyWith(
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Auto-refresh indicator
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.sync,
                                size: 16,
                                color: appColors?.primary,
                              ),
                              const SizedBox(width: 4),
                              Text('Auto-sync', style: context.bodySmall()),
                            ],
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            context.read<ClientBloc>().add(
                              const ClientEvent.disconnect(),
                            );
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text('Disconnect'),
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Upload Zone
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: InkWell(
                      onTap: _uploadFile,
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: appColors?.primary ?? Colors.blue,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: appColors?.primary?.withValues(alpha: 0.05),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.cloud_upload,
                              size: 48,
                              color: appColors?.primary,
                            ),
                            const SizedBox(height: 8),
                            Text('Tap to Browse', style: context.titleMedium()),
                            // Text('or drop files here', style: context.bodySmall()),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Files List Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Host Files', style: context.titleMedium()),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () {
                            context.read<ClientBloc>().add(
                              const ClientEvent.fetchFiles(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Files List
                  Expanded(
                    child: state.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // HOST FILES SECTION
                                if (fileList.any((f) => !f.isUploaded)) ...[
                                  Text(
                                    'Host Files',
                                    style: context.titleMedium(),
                                  ),
                                  const SizedBox(height: 8),
                                  ...fileList
                                      .where((f) => !f.isUploaded)
                                      .map(
                                        (file) => _buildFileCard(
                                          context,
                                          file,
                                          appColors,
                                          connectionInfo,
                                        ),
                                      ),
                                  const SizedBox(height: 24),
                                ],

                                // UPLOADED FILES SECTION
                                if (fileList.any((f) => f.isUploaded)) ...[
                                  Text(
                                    'Uploaded Files',
                                    style: context.titleMedium(),
                                  ),
                                  const SizedBox(height: 8),
                                  ...fileList
                                      .where((f) => f.isUploaded)
                                      .map(
                                        (file) => _buildFileCard(
                                          context,
                                          file,
                                          appColors,
                                          connectionInfo,
                                        ),
                                      ),
                                ],

                                if (fileList.isEmpty)
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 32),
                                      child: Text(
                                        'No files available',
                                        style: context.bodyMedium(),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFileCard(
    BuildContext context,
    dynamic file,
    dynamic appColors,
    dynamic connectionInfo,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(_getFileIcon(file.mimeType), color: appColors?.primary),
        title: Text(file.name),
        subtitle: Text('${(file.size / 1024 / 1024).toStringAsFixed(2)} MB'),
        trailing: IconButton(
          icon: const Icon(Icons.download),
          onPressed: () {
            _downloadFile(file.name, connectionInfo.serverUrl ?? '');
          },
        ),
      ),
    );
  }

  IconData _getFileIcon(String mimeType) {
    if (mimeType.startsWith('image/')) return Icons.image;
    if (mimeType.startsWith('video/')) return Icons.video_file;
    if (mimeType.startsWith('audio/')) return Icons.audio_file;
    if (mimeType.contains('pdf')) return Icons.picture_as_pdf;
    if (mimeType.contains('zip') || mimeType.contains('archive')) {
      return Icons.folder_zip;
    }
    return Icons.insert_drive_file;
  }
}
