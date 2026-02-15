import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_sharing/core/extensions/theme_ext.dart';
import 'package:file_sharing/core/services/sharedprefs_services.dart';
import 'package:file_sharing/core/theme/theme_notifier.dart';
import '../bloc/server_bloc.dart';
import '../widgets/server_idle_view.dart';
import '../widgets/connection_details_card.dart';
import '../widgets/server_stats_row.dart';
import '../widgets/file_section.dart';
import 'package:file_sharing/common/widgets/loading.dart';

ValueNotifier<bool> isSharedByMe = ValueNotifier<bool>(true);

class HostDashboardScreen extends StatefulWidget {
  const HostDashboardScreen({super.key});

  @override
  State<HostDashboardScreen> createState() => _HostDashboardScreenState();
}

class _HostDashboardScreenState extends State<HostDashboardScreen> {
  final ValueNotifier<bool> isSharedByMe = ValueNotifier(true); // Moved here
  bool _isPicking = false;

  Future<void> _pickAndAddFile() async {
    setState(() => _isPicking = true);
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
    } finally {
      if (mounted) {
        setState(() => _isPicking = false);
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
                  final newMode = themeMode == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark;
                  themeNotifier.value = newMode;
                  SharedPrefsServices.instance.setThemeMode(
                    newMode == ThemeMode.dark,
                  );
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

          return Loading(
            isLoading: _isPicking || state.isLoading,
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            ConnectionDetailsCard(serverInfo: serverInfo),
                            const SizedBox(height: 16),
                            ServerStatsRow(serverInfo: serverInfo),
                            const SizedBox(height: 16),
                            ValueListenableBuilder<bool>(
                              valueListenable: isSharedByMe,
                              builder: (context, isShared, _) {
                                return Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: context.appColors?.surfaceColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color:
                                          context.appColors?.onSurface
                                              ?.withValues(alpha: 0.1) ??
                                          Colors.grey,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () =>
                                              isSharedByMe.value = true,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isShared
                                                  ? context.appColors?.primary
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              'Shared by me',
                                              textAlign: TextAlign.center,
                                              style: isShared
                                                  ? context
                                                        .bodyMedium()
                                                        ?.copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )
                                                  : context
                                                        .bodyMedium()
                                                        ?.copyWith(
                                                          color: context
                                                              .appColors
                                                              ?.onSurface
                                                              ?.withValues(
                                                                alpha: 0.6,
                                                              ),
                                                        ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () =>
                                              isSharedByMe.value = false,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: !isShared
                                                  ? context.appColors?.primary
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              'Shared to me',
                                              textAlign: TextAlign.center,
                                              style: !isShared
                                                  ? context
                                                        .bodyMedium()
                                                        ?.copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )
                                                  : context
                                                        .bodyMedium()
                                                        ?.copyWith(
                                                          color: context
                                                              .appColors
                                                              ?.onSurface
                                                              ?.withValues(
                                                                alpha: 0.6,
                                                              ),
                                                        ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                          ]),
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: isSharedByMe,
                        builder: (context, isShared, _) {
                          final sentFiles = serverInfo.sharedFiles
                              .where((f) => !f.isUploaded)
                              .toList();
                          final receivedFiles = serverInfo.sharedFiles
                              .where((f) => f.isUploaded)
                              .toList();

                          if (isShared) {
                            if (sentFiles.isEmpty) {
                              return SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.folder_open_outlined,
                                        size: 64,
                                        color: context.appColors?.onSurface
                                            ?.withValues(alpha: 0.2),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'No files shared yet',
                                        style: context.bodyMedium()?.copyWith(
                                          color: context.appColors?.onSurface
                                              ?.withValues(alpha: 0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return FileSection(
                              title: 'Shared from App',
                              files: sentFiles,
                            );
                          } else {
                            if (receivedFiles.isEmpty) {
                              return SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.move_to_inbox_outlined,
                                        size: 64,
                                        color: context.appColors?.onSurface
                                            ?.withValues(alpha: 0.2),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'No files received yet',
                                        style: context.bodyMedium()?.copyWith(
                                          color: context.appColors?.onSurface
                                              ?.withValues(alpha: 0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return FileSection(
                              title: 'Received from Web',
                              files: receivedFiles,
                            );
                          }
                        },
                      ),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
                    ],
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: isSharedByMe,
                  builder: (context, isShared, _) {
                    if (!isShared) return const SizedBox.shrink();

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.appColors?.surfaceColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: SafeArea(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _pickAndAddFile,
                            icon: const Icon(Icons.cloud_upload),
                            label: const Text('Select Files to Share'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.appColors?.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
