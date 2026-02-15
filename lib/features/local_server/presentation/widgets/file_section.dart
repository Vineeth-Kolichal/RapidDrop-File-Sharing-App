import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_sharing/core/extensions/theme_ext.dart';
import 'package:file_sharing/core/theme/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../../domain/entities/shared_file.dart';
import '../bloc/server_bloc.dart';

class FileSection extends StatefulWidget {
  final String title;
  final List<SharedFile> files;

  const FileSection({super.key, required this.title, required this.files});

  @override
  State<FileSection> createState() => _FileSectionState();
}

class _FileSectionState extends State<FileSection> {
  final Set<String> _downloadedFiles = {};
  static const platform = MethodChannel('com.devdecode.rapiddrop/files');

  Future<void> _saveToDownloads(SharedFile file) async {
    try {
      if (Platform.isAndroid) {
        // Check Android version
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final sdkInt = androidInfo.version.sdkInt;

        if (sdkInt < 29) {
          // Android 9 (Pie) and below need runtime permission
          var status = await Permission.storage.status;
          if (!status.isGranted) {
            status = await Permission.storage.request();
            if (!status.isGranted) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Storage permission required to save files'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              return;
            }
          }
        }
        // For Android 10+ (SDK 29+), no permission needed for MediaStore downloads

        final String result = await platform.invokeMethod(
          'saveFileToDownloads',
          {'path': file.path, 'name': file.name},
        );

        debugPrint('File saved to: $result');
      } else {
        // Non-Android platforms (e.g. desktop)
        final directory = await getDownloadsDirectory();
        if (directory == null) {
          throw Exception('Could not determine downloads directory');
        }

        final sourceFile = File(file.path);
        if (!await sourceFile.exists()) {
          throw Exception('Source file not found');
        }

        final targetPath = '${directory.path}/${file.name}';
        await sourceFile.copy(targetPath);
      }

      setState(() {
        _downloadedFiles.add(file.name);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Saved to Downloads: ${file.name}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.files.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title, style: context.titleMedium()),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement clear all
                      },
                      child: Text(
                        '${widget.files.length} files',
                        style: context.bodySmall(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final file = widget.files[index];
              final isUploaded = file.isUploaded;
              final isDownloaded = _downloadedFiles.contains(file.name);

              return _buildFileCard(context, file, isUploaded, isDownloaded);
            }, childCount: widget.files.length),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
        ],
      ),
    );
  }

  Widget _buildFileCard(
    BuildContext context,
    SharedFile file,
    bool isUploaded,
    bool isDownloaded,
  ) {
    final appColors = context.appColors;
    final fileTypeColor = _getFileTypeColor(file.mimeType, appColors);

    return Container(
      decoration: BoxDecoration(
        color: context.isDarkTheme ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.isDarkTheme ? Colors.grey[800]! : Colors.grey[200]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!file.mimeType.startsWith('image/')) const SizedBox(height: 16),
          Expanded(
            child: file.mimeType.startsWith('image/')
                ? ClipRRect(
                    borderRadius: BorderRadiusGeometry.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.file(
                      width: double.infinity,
                      File(file.path),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          _getFileIcon(file.mimeType),
                          color: fileTypeColor,
                          size: 32,
                        );
                      },
                    ),
                  )
                : Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: fileTypeColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Icon(
                        _getFileIcon(file.mimeType),
                        color: fileTypeColor,
                        size: 32,
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Text(
                  file.name,
                  style: context.bodyMedium()?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _formatFileSize(file.size),
                  style: context.bodySmall()?.copyWith(
                    color: context.appColors?.onSurface?.withValues(alpha: 0.5),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: InkWell(
              onTap: isUploaded
                  ? () {
                      if (!isDownloaded) {
                        _saveToDownloads(file);
                      } else {
                        // TODO: Implement open file
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('File already downloaded'),
                          ),
                        );
                      }
                    }
                  : () {
                      context.read<ServerBloc>().add(
                        ServerEvent.removeFile(file.name),
                      );
                    },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isUploaded
                      ? (isDownloaded
                            ? Colors.green.withValues(alpha: 0.1)
                            : appColors?.primary?.withValues(alpha: 0.1))
                      : Colors.red.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Text(
                  isUploaded
                      ? (isDownloaded ? 'Downloaded' : 'Download')
                      : 'Remove',
                  style: context.labelMedium()?.copyWith(
                    color: isUploaded
                        ? (isDownloaded ? Colors.green : appColors?.primary)
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getFileTypeColor(String mimeType, AppColors? appColors) {
    if (mimeType.startsWith('image/')) {
      return appColors?.primary ?? Colors.blue;
    }
    if (mimeType.startsWith('video/')) return Colors.orange;
    if (mimeType.startsWith('audio/')) return Colors.purple;
    if (mimeType.contains('pdf')) return Colors.red;
    if (mimeType.contains('zip') || mimeType.contains('archive')) {
      return Colors.amber;
    }
    if (mimeType.contains('text/')) return Colors.grey;
    return Colors.blueGrey;
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  IconData _getFileIcon(String mimeType) {
    if (mimeType.startsWith('image/')) return Icons.image;
    if (mimeType.startsWith('video/')) return Icons.play_circle_outline;
    if (mimeType.startsWith('audio/')) return Icons.music_note;
    if (mimeType.contains('pdf')) return Icons.picture_as_pdf;
    if (mimeType.contains('zip') || mimeType.contains('archive')) {
      return Icons.folder_zip;
    }
    if (mimeType.contains('text/')) return Icons.description;
    return Icons.insert_drive_file;
  }
}
