import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_sharing/core/extensions/theme_ext.dart';
import 'package:file_sharing/core/theme/theme_notifier.dart';
import '../bloc/server_bloc.dart';
import '../widgets/server_idle_view.dart';
import '../widgets/connection_details_card.dart';
import '../widgets/server_stats_row.dart';
import '../widgets/file_section.dart';

class HostDashboardScreen extends StatefulWidget {
  const HostDashboardScreen({super.key});

  @override
  State<HostDashboardScreen> createState() => _HostDashboardScreenState();
}

class _HostDashboardScreenState extends State<HostDashboardScreen> {
  Future<void> _pickAndAddFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.any,
      );

      if (result == null) return;

      if (result.files.single.path == null) {
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
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (context, themeMode, _) {
              return IconButton(
                icon: Icon(
                  themeMode == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                tooltip: 'Toggle Theme',
                onPressed: () {
                  themeNotifier.value = themeMode == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark;
                },
              );
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
            return const ServerIdleView();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ConnectionDetailsCard(serverInfo: serverInfo),
                const SizedBox(height: 16),
                ServerStatsRow(serverInfo: serverInfo),
                const SizedBox(height: 16),
                if (serverInfo.sharedFiles.isNotEmpty) ...[
                  FileSection(
                    title: 'Shared from App',
                    files: serverInfo.sharedFiles
                        .where((f) => !f.isUploaded)
                        .toList(),
                  ),
                  FileSection(
                    title: 'Received from Web',
                    files: serverInfo.sharedFiles
                        .where((f) => f.isUploaded)
                        .toList(),
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
      floatingActionButton: BlocBuilder<ServerBloc, ServerState>(
        builder: (context, state) {
          final serverInfo = state.serverInfo;
          if (serverInfo == null || !serverInfo.isRunning) {
            return const SizedBox.shrink();
          }
          return FloatingActionButton.extended(
            onPressed: _pickAndAddFile,
            icon: const Icon(Icons.add),
            label: const Text('Add Files'),
          );
        },
      ),
    );
  }
}
