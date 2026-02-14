import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_sharing/core/extensions/theme_ext.dart';
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

  Future<void> _saveToDownloads(SharedFile file) async {
    try {
      final sourceFile = File(file.path);
      if (!await sourceFile.exists()) {
        throw Exception('Source file not found');
      }

      String? downloadPath;
      if (Platform.isAndroid) {
        downloadPath = '/storage/emulated/0/Download';
      } else {
        final directory = await getDownloadsDirectory();
        downloadPath = directory?.path;
      }

      if (downloadPath == null) {
        throw Exception('Could not determine downloads directory');
      }

      final targetPath = '$downloadPath/${file.name}';
      await sourceFile.copy(targetPath);

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
    if (widget.files.isEmpty) return const SizedBox.shrink();

    final appColors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title, style: context.titleMedium()),
            Text('${widget.files.length} files', style: context.bodySmall()),
          ],
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.files.length,
          itemBuilder: (context, index) {
            final file = widget.files[index];
            final isUploaded = file.isUploaded;

            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Icon(
                  _getFileIcon(file.mimeType),
                  color: appColors?.primary,
                ),
                title: Text(file.name),
                subtitle: Text(
                  '${(file.size / 1024 / 1024).toStringAsFixed(2)} MB',
                ),
                trailing: isUploaded
                    ? _downloadedFiles.contains(file.name)
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : IconButton(
                              icon: const Icon(Icons.download),
                              tooltip: 'Save to Downloads',
                              onPressed: () => _saveToDownloads(file),
                            )
                    : IconButton(
                        icon: const Icon(Icons.close),
                        tooltip: 'Stop Sharing',
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
        const SizedBox(height: 70),
      ],
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
