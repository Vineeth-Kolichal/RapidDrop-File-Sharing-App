import 'package:file_sharing/core/extensions/theme_ext.dart';
import 'package:file_sharing/features/web_client/domain/entities/remote_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../core/theme/app_colors.dart';
import '../bloc/client_bloc.dart';

class ClientFileSection extends StatefulWidget {
  final String title;
  final List<RemoteFile> files;
  final String? serverUrl;

  const ClientFileSection({
    super.key,
    required this.title,
    required this.files,
    this.serverUrl,
  });

  @override
  State<ClientFileSection> createState() => _ClientFileSectionState();
}

class _ClientFileSectionState extends State<ClientFileSection> {
  final Set<String> _downloadedFiles = {};

  Future<void> _downloadFile(String filename) async {
    if (!kIsWeb) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Download only supported on web')),
        );
      }
      return;
    }

    try {
      final downloadUrl = '${widget.serverUrl}/download/$filename';
      final anchor = html.AnchorElement(href: downloadUrl)
        ..setAttribute('download', filename)
        ..style.display = 'none';

      anchor.click();

      setState(() {
        _downloadedFiles.add(filename);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Download failed: $e')));
      }
    }
  }

  Color _getFileTypeColor(String mimeType, AppColors? appColors) {
    if (mimeType.contains('pdf')) return const Color(0xFFE57373); // Red
    if (mimeType.startsWith('image/')) {
      return appColors?.primary ?? Colors.blue;
    }
    if (mimeType.contains('zip') || mimeType.contains('compressed')) {
      return const Color(0xFFFFB74D); // Orange/Yellow
    }
    if (mimeType.startsWith('video/')) return const Color(0xFF9575CD); // Purple
    if (mimeType.startsWith('audio/')) return const Color(0xFF4DB6AC); // Teal
    return Colors.grey;
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

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
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
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title, style: context.titleMedium()),
                  Text(
                    '${widget.files.length} files',
                    style: context.bodySmall(),
                  ),
                ],
              ),
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
              return _buildFileCard(context, file);
            }, childCount: widget.files.length),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
        ],
      ),
    );
  }

  Widget _buildFileCard(BuildContext context, RemoteFile file) {
    final appColors = context.appColors;
    final typeColor = _getFileTypeColor(file.mimeType, appColors);
    final isDownloaded = _downloadedFiles.contains(file.name);

    return Container(
      decoration: BoxDecoration(
        color: context.appColors?.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Icon(
                  _getFileIcon(file.mimeType),
                  size: 48,
                  color: typeColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyMedium().copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(_formatFileSize(file.size), style: context.bodySmall()),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color:
                      context.appColors?.onSurface?.withValues(alpha: 0.1) ??
                      Colors.grey.shade200,
                ),
              ),
            ),
            child: file.isUploaded
                ? InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete File'),
                          content: Text(
                            'Are you sure you want to delete "${file.name}"?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.read<ClientBloc>().add(
                                  ClientEvent.deleteFile(file.name),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete_outline,
                            size: 20,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Remove',
                            style: context.bodySmall().copyWith(
                              color: Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () => _downloadFile(file.name),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isDownloaded
                                ? Icons.check_circle_outline
                                : Icons.download_rounded,
                            size: 20,
                            color: isDownloaded
                                ? Colors.green
                                : context.appColors?.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isDownloaded ? 'Downloaded' : 'Download',
                            style: context.bodySmall().copyWith(
                              color: isDownloaded
                                  ? Colors.green
                                  : context.appColors?.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
