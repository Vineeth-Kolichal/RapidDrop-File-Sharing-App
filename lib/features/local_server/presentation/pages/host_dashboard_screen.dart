import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:file_sharing/core/extensions/theme_ext.dart';
import '../bloc/server_bloc.dart';

class HostDashboardScreen extends StatefulWidget {
  const HostDashboardScreen({super.key});

  @override
  State<HostDashboardScreen> createState() => _HostDashboardScreenState();
}

class _HostDashboardScreenState extends State<HostDashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Server will be started manually via button
  }

  Future<void> _pickAndAddFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.any,
      );

      if (result == null) {
        // User cancelled the picker
        return;
      }

      if (result.files.single.path == null) {
        // Path is null - this can happen on some platforms
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Error: Could not access file path. Try selecting a different file.',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      final filePath = result.files.single.path!;
      final fileSize = result.files.single.size;

      // Log file info for debugging
      debugPrint('Selected file: $filePath');
      debugPrint(
        'File size: ${(fileSize / 1024 / 1024).toStringAsFixed(2)} MB',
      );

      if (mounted) {
        context.read<ServerBloc>().add(ServerEvent.addFile(filePath));
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to select file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Scaffold(
      backgroundColor: appColors?.surfaceColor,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Host Dashboard', style: context.titleMedium()),
            Text(
              'Local Network Share',
              style: context.bodySmall()?.copyWith(
                color: appColors?.onSurface?.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        actions: [
          BlocBuilder<ServerBloc, ServerState>(
            builder: (context, state) {
              final serverInfo = state.serverInfo;
              if (serverInfo != null && serverInfo.isRunning) {
                return IconButton(
                  icon: const Icon(Icons.stop),
                  tooltip: 'Stop Server',
                  onPressed: () {
                    context.read<ServerBloc>().add(
                      const ServerEvent.stopServer(),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<ServerBloc, ServerState>(
        builder: (context, state) {
          if (state.isLoading && state.serverInfo == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null && state.serverInfo == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: appColors?.primary,
                    ),
                    const SizedBox(height: 16),
                    Text('Error', style: context.titleLarge()),
                    const SizedBox(height: 8),
                    Text(state.error!, textAlign: TextAlign.center),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ServerBloc>().add(
                          const ServerEvent.startServer(),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final serverInfo = state.serverInfo;
          if (serverInfo == null || !serverInfo.isRunning) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_off, size: 64, color: appColors?.primary),
                  const SizedBox(height: 24),
                  Text('Server is not running', style: context.titleLarge()),
                  const SizedBox(height: 8),
                  Text(
                    'Start the server to share files',
                    style: context.bodyMedium(),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: state.isLoading
                        ? null
                        : () {
                            context.read<ServerBloc>().add(
                              const ServerEvent.startServer(),
                            );
                          },
                    icon: state.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.play_arrow),
                    label: Text(
                      state.isLoading ? 'Starting...' : 'Start Server',
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Connection Card with QR Code
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Connection Details',
                          style: context.titleMedium(),
                        ),
                        const SizedBox(height: 16),
                        // PIN Display
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: appColors?.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Access PIN',
                                style: context.bodySmall()?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    serverInfo.pin,
                                    style: const TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 8,
                                      fontFamily: 'monospace',
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  IconButton(
                                    onPressed: () {
                                      // Copy PIN to clipboard
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'PIN copied to clipboard',
                                          ),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.copy,
                                      color: Colors.white,
                                    ),
                                    tooltip: 'Copy PIN',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        if (serverInfo.ipAddress != null)
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: QrImageView(
                              data: serverInfo.serverUrl,
                              version: QrVersions.auto,
                              size: 200.0,
                            ),
                          ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: appColors?.primary?.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.link, color: appColors?.primary),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  serverInfo.serverUrl,
                                  style: context.bodyMedium()?.copyWith(
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Stats
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text('Total Files', style: context.bodySmall()),
                              const SizedBox(height: 4),
                              Text(
                                '${serverInfo.sharedFiles.length}',
                                style: context.headlineMedium(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text('Port', style: context.bodySmall()),
                              const SizedBox(height: 4),
                              Text(
                                '${serverInfo.port}',
                                style: context.headlineMedium(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Files List
                if (serverInfo.sharedFiles.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Shared Files', style: context.titleMedium()),
                      Text(
                        '${serverInfo.sharedFiles.length} files',
                        style: context.bodySmall(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: serverInfo.sharedFiles.length,
                    itemBuilder: (context, index) {
                      final file = serverInfo.sharedFiles[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Icon(
                            Icons.insert_drive_file,
                            color: appColors?.primary,
                          ),
                          title: Text(file.name),
                          subtitle: Text(
                            '${(file.size / 1024 / 1024).toStringAsFixed(2)} MB',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context.read<ServerBloc>().add(
                                ServerEvent.removeFile(file.name),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ] else
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      'No files shared yet',
                      style: context.bodyMedium(),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _pickAndAddFile,
        icon: const Icon(Icons.add),
        label: const Text('Add Files'),
      ),
    );
  }
}
