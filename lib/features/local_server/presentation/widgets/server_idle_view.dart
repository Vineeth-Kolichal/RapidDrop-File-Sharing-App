import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_sharing/core/extensions/theme_ext.dart';
import '../bloc/server_bloc.dart';

class ServerIdleView extends StatelessWidget {
  const ServerIdleView({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return BlocBuilder<ServerBloc, ServerState>(
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'assets/app_icon.png',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 16),
              Text('RapidDrop', style: context.headlineMedium()),
              const SizedBox(height: 8),
              Text(
                'Share files instantly across devices',
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
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.play_arrow),
                label: Text(state.isLoading ? 'Starting...' : 'Start Sharing'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors?.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
