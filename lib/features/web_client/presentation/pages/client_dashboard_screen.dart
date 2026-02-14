import 'dart:ui';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:cross_file/cross_file.dart';
import 'package:file_sharing/common/widgets/responsive.dart';
import 'package:file_sharing/core/extensions/theme_ext.dart';
import 'package:file_sharing/core/services/sharedprefs_services.dart';
import 'package:file_sharing/core/theme/theme_notifier.dart';
import 'package:file_sharing/features/web_client/domain/entities/file_entity.dart';
import 'package:file_sharing/features/web_client/domain/entities/remote_file.dart';
import 'package:file_sharing/features/web_client/presentation/widgets/client_connection_card.dart';
import 'package:file_sharing/features/web_client/presentation/widgets/client_file_section.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/client_bloc.dart';

class ClientDashboardScreen extends StatefulWidget {
  const ClientDashboardScreen({super.key});

  @override
  State<ClientDashboardScreen> createState() => _ClientDashboardScreenState();
}

class _ClientDashboardScreenState extends State<ClientDashboardScreen> {
  final TextEditingController _pinController = TextEditingController();
  final ValueNotifier<bool> isHostFiles = ValueNotifier(true);
  final ValueNotifier<bool> isDragging = ValueNotifier(false);

  @override
  void dispose() {
    _pinController.dispose();
    isHostFiles.dispose();
    isDragging.dispose();
    super.dispose();
  }

  Future<void> _uploadFile() async {
    final result = await FilePicker.platform.pickFiles(withData: true);

    if (result != null && result.files.isNotEmpty) {
      final pickedFile = result.files.single;
      FileEntity fileEntity;

      if (kIsWeb) {
        if (pickedFile.bytes != null) {
          fileEntity = FileEntity(
            name: pickedFile.name,
            bytes: pickedFile.bytes,
          );
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to load file data')),
            );
          }
          return;
        }
      } else {
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
        isHostFiles.value = false;
        context.read<ClientBloc>().add(ClientEvent.uploadFile(fileEntity));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Scaffold(
      backgroundColor: appColors?.surfaceColor,
      appBar: AppBar(
        title: const Text('Rapid Drop Client'),
        actions: [
          IconButton(
            onPressed: () {
              final newMode = themeNotifier.value == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
              themeNotifier.value = newMode;
              SharedPrefsServices.instance.setThemeMode(
                newMode == ThemeMode.dark,
              );
            },
            icon: ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder: (context, mode, _) {
                return Icon(
                  mode == ThemeMode.light
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                );
              },
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: BlocConsumer<ClientBloc, ClientState>(
            listener: (context, state) {
              if (state.error != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error!)));
              }
            },
            builder: (context, state) {
              if (state.connectionInfo == null ||
                  !state.connectionInfo!.isConnected) {
                return _buildPinEntry(context, state);
              }

              final fileList = state.fileList ?? [];
              final hostFiles = fileList.where((f) => !f.isUploaded).toList();
              final uploadedFiles = fileList
                  .where((f) => f.isUploaded)
                  .toList();

              return Responsive(
                desktop: _buildDesktopLayout(
                  context,
                  state,
                  hostFiles,
                  uploadedFiles,
                ),
                mobile: _buildMobileLayout(
                  context,
                  state,
                  hostFiles,
                  uploadedFiles,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    ClientState state,
    List<RemoteFile> hostFiles,
    List<RemoteFile> uploadedFiles,
  ) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column: Upload Zone
          Expanded(flex: 5, child: _buildUploadZone(context)),
          const SizedBox(width: 24),
          // Right Column: Available Files
          Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                color: context.appColors?.surfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color:
                      context.appColors?.onSurface?.withValues(alpha: 0.1) ??
                      Colors.grey.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClientConnectionCard(
                      connectionInfo: state.connectionInfo!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildTabSwitcher(context),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        _buildFileGridSliver(
                          context,
                          state,
                          hostFiles,
                          uploadedFiles,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    ClientState state,
    List<RemoteFile> hostFiles,
    List<RemoteFile> uploadedFiles,
  ) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    ClientConnectionCard(connectionInfo: state.connectionInfo!),
                    const SizedBox(height: 24),
                    _buildTabSwitcher(context),
                    const SizedBox(height: 24),
                  ]),
                ),
              ),
              _buildFileGridSliver(context, state, hostFiles, uploadedFiles),
              const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
            ],
          ),
        ),
        _buildFixedUploadButton(context),
      ],
    );
  }

  Widget _buildUploadZone(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.appColors?.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              context.appColors?.onSurface?.withValues(alpha: 0.1) ??
              Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.upload_file,
                color: context.appColors?.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text('Send Files', style: context.titleLarge()),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ValueListenableBuilder<bool>(
              valueListenable: isDragging,
              builder: (context, dragging, child) {
                return DropTarget(
                  onDragDone: (details) async {
                    if (details.files.isNotEmpty) {
                      for (final XFile file in details.files) {
                        FileEntity fileEntity;
                        if (kIsWeb) {
                          final bytes = await file.readAsBytes();
                          fileEntity = FileEntity(
                            name: file.name,
                            bytes: bytes,
                          );
                        } else {
                          fileEntity = FileEntity(
                            name: file.name,
                            path: file.path,
                          );
                        }
                        if (mounted) {
                          isHostFiles.value = false;
                          context.read<ClientBloc>().add(
                            ClientEvent.uploadFile(fileEntity),
                          );
                        }
                      }
                    }
                  },
                  onDragEntered: (details) {
                    isDragging.value = true;
                  },
                  onDragExited: (details) {
                    isDragging.value = false;
                  },
                  child: InkWell(
                    onTap: _uploadFile,
                    borderRadius: BorderRadius.circular(16),
                    child: CustomPaint(
                      painter: _DashedBorderPainter(
                        color: dragging
                            ? context.appColors?.primary ?? Colors.blue
                            : context.appColors?.primary?.withValues(
                                    alpha: 0.3,
                                  ) ??
                                  Colors.blue.withValues(alpha: 0.3),
                        strokeWidth: dragging ? 3 : 2,
                        gap: 8,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: dragging
                              ? context.appColors?.primary?.withValues(
                                  alpha: 0.1,
                                )
                              : context.appColors?.primary?.withValues(
                                  alpha: 0.05,
                                ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: context.appColors?.surfaceColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.cloud_upload_outlined,
                                size: 48,
                                color: context.appColors?.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              dragging ? 'Drop files here' : 'Upload Zone',
                              style: context.titleMedium().copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              dragging
                                  ? 'Release to upload'
                                  : 'Drag & Drop file here or click to browse',
                              textAlign: TextAlign.center,
                              style: context.bodyMedium().copyWith(
                                color: context.appColors?.onSurface?.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: _uploadFile,
                              icon: const Icon(Icons.folder_open),
                              label: const Text('Browse Files to Send'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.appColors?.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSwitcher(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.appColors?.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              context.appColors?.onSurface?.withValues(alpha: 0.1) ??
              Colors.grey,
        ),
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable: isHostFiles,
        builder: (context, isHost, _) {
          return Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => isHostFiles.value = true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isHost
                          ? context.appColors?.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Host Files',
                      textAlign: TextAlign.center,
                      style: isHost
                          ? context.bodyMedium().copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )
                          : context.bodyMedium().copyWith(
                              color: context.appColors?.onSurface?.withValues(
                                alpha: 0.6,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => isHostFiles.value = false,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: !isHost
                          ? context.appColors?.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'My Uploads',
                      textAlign: TextAlign.center,
                      style: !isHost
                          ? context.bodyMedium().copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )
                          : context.bodyMedium().copyWith(
                              color: context.appColors?.onSurface?.withValues(
                                alpha: 0.6,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFileGridSliver(
    BuildContext context,
    ClientState state,
    List<RemoteFile> hostFiles,
    List<RemoteFile> uploadedFiles,
  ) {
    return ValueListenableBuilder<bool>(
      valueListenable: isHostFiles,
      builder: (context, isHost, _) {
        if (isHost) {
          if (hostFiles.isEmpty) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_download_outlined,
                      size: 64,
                      color: context.appColors?.onSurface?.withValues(
                        alpha: 0.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No files shared by host',
                      style: context.bodyMedium().copyWith(
                        color: context.appColors?.onSurface?.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return ClientFileSection(
            title: 'Shared by Host',
            files: hostFiles,
            serverUrl: state.connectionInfo?.serverUrl,
          );
        } else {
          if (uploadedFiles.isEmpty) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 64,
                      color: context.appColors?.onSurface?.withValues(
                        alpha: 0.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'You haven\'t uploaded any files',
                      style: context.bodyMedium().copyWith(
                        color: context.appColors?.onSurface?.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return ClientFileSection(
            title: 'Uploaded by Me',
            files: uploadedFiles,
            serverUrl: state.connectionInfo?.serverUrl,
          );
        }
      },
    );
  }

  Widget _buildFixedUploadButton(BuildContext context) {
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
            onPressed: _uploadFile,
            icon: const Icon(Icons.cloud_upload),
            label: const Text('Send File to Host'),
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
  }

  Widget _buildPinEntry(BuildContext context, ClientState state) {
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
                  color: context.appColors?.primary,
                ),
                const SizedBox(height: 16),
                Text('Enter Access PIN', style: context.titleLarge()),
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
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.lock_open),
                    label: Text(state.isLoading ? 'Validating...' : 'Connect'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.appColors?.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  _DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(16),
        ),
      );

    final Path dashedPath = _dashPath(
      path,
      dashArray: CircularIntervalList<double>([gap, gap]),
    );

    canvas.drawPath(dashedPath, paint);
  }

  Path _dashPath(
    Path source, {
    required CircularIntervalList<double> dashArray,
  }) {
    final Path dest = Path();
    for (final PathMetric metric in source.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;
      while (distance < metric.length) {
        final double len = dashArray.next;
        if (draw) {
          dest.addPath(
            metric.extractPath(distance, distance + len),
            Offset.zero,
          );
        }
        distance += len;
        draw = !draw;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gap != gap;
  }
}

class CircularIntervalList<T> {
  final List<T> _vals;
  int _idx = 0;

  CircularIntervalList(this._vals);

  T get next {
    if (_idx >= _vals.length) {
      _idx = 0;
    }
    return _vals[_idx++];
  }
}
