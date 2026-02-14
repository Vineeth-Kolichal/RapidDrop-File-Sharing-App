import 'package:file_sharing/core/extensions/theme_ext.dart';
import 'package:file_sharing/core/services/sharedprefs_services.dart';
import 'package:file_sharing/core/theme/theme_notifier.dart';
import 'package:file_sharing/features/web_client/domain/entities/file_entity.dart';
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

  @override
  void dispose() {
    _pinController.dispose();
    isHostFiles.dispose();
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
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
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

              return Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.all(16),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate([
                              ClientConnectionCard(
                                connectionInfo: state.connectionInfo!,
                              ),
                              const SizedBox(height: 24),
                              // Tab Switcher
                              Container(
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
                                child: ValueListenableBuilder<bool>(
                                  valueListenable: isHostFiles,
                                  builder: (context, isHost, _) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () =>
                                                isHostFiles.value = true,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: isHost
                                                    ? context.appColors?.primary
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                'Host Files',
                                                textAlign: TextAlign.center,
                                                style: isHost
                                                    ? context
                                                          .bodyMedium()
                                                          .copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )
                                                    : context
                                                          .bodyMedium()
                                                          .copyWith(
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
                                                isHostFiles.value = false,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: !isHost
                                                    ? context.appColors?.primary
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                'My Uploads',
                                                textAlign: TextAlign.center,
                                                style: !isHost
                                                    ? context
                                                          .bodyMedium()
                                                          .copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )
                                                    : context
                                                          .bodyMedium()
                                                          .copyWith(
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
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 24),
                            ]),
                          ),
                        ),
                        // File Grids
                        ValueListenableBuilder<bool>(
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
                                          color: context.appColors?.onSurface
                                              ?.withValues(alpha: 0.2),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'No files shared by host',
                                          style: context.bodyMedium().copyWith(
                                            color: context.appColors?.onSurface
                                                ?.withValues(alpha: 0.5),
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
                                          color: context.appColors?.onSurface
                                              ?.withValues(alpha: 0.2),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'You haven\'t uploaded any files',
                                          style: context.bodyMedium().copyWith(
                                            color: context.appColors?.onSurface
                                                ?.withValues(alpha: 0.5),
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
                        ),
                        const SliverPadding(
                          padding: EdgeInsets.only(bottom: 100),
                        ),
                      ],
                    ),
                  ),
                  // Fixed Upload Button
                  Container(
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
                  ),
                ],
              );
            },
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
