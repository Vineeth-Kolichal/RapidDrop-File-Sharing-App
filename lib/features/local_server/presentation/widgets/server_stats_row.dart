import 'package:flutter/material.dart';
import 'package:file_sharing/core/extensions/theme_ext.dart';
import '../../domain/entities/server_info.dart';

class ServerStatsRow extends StatelessWidget {
  final ServerInfo serverInfo;

  const ServerStatsRow({super.key, required this.serverInfo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: context.appColors?.primary?.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
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
          child: Container(
            decoration: BoxDecoration(
              color: context.appColors?.primary?.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Port', style: context.bodySmall()),
                  const SizedBox(height: 4),
                  Text('${serverInfo.port}', style: context.headlineMedium()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
