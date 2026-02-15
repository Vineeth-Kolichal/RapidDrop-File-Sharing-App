import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:file_sharing/core/extensions/theme_ext.dart';
import '../../domain/entities/server_info.dart';
import '../bloc/server_bloc.dart';

class ConnectionDetailsCard extends StatelessWidget {
  final ServerInfo serverInfo;

  const ConnectionDetailsCard({super.key, required this.serverInfo});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Container(
      decoration: BoxDecoration(
        color: appColors?.onSurface?.withValues(alpha: 0.02),
        border: Border.all(
          color: appColors?.primary?.withValues(alpha: 0.1) ?? Colors.grey,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // PIN Display
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: appColors?.primary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('PIN copied to clipboard'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy, color: Colors.white),
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
          //url section
          //url section
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: serverInfo.serverUrl));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Server URL copied to clipboard'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: appColors?.primary?.withValues(alpha: 0.1),
                // borderRadius: BorderRadius.circular(8),
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
                  const SizedBox(width: 8),
                  Icon(
                    Icons.copy,
                    size: 16,
                    color: appColors?.primary?.withValues(alpha: 0.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<ServerBloc>().add(const ServerEvent.stopServer());
              },
              icon: const Icon(Icons.stop),
              label: const Text('Stop Sharing'),
              style: ElevatedButton.styleFrom(
                backgroundColor: appColors?.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
