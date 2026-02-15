import 'dart:io';
import 'package:file_sharing/core/theme/theme_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/dependency_injection/config/configure_injection.dart';
import 'core/theme/theme.dart';
import 'features/local_server/presentation/bloc/server_bloc.dart';
import 'features/web_client/presentation/bloc/client_bloc.dart';
import 'features/local_server/presentation/pages/host_dashboard_screen.dart';
import 'features/web_client/presentation/pages/client_dashboard_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Text styles
    TextTheme appTextTheme = AppTextStyles.getTextTheme();
    // Theme
    AppTheme theme = AppTheme(appTextTheme);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ServerBloc>()),
        BlocProvider(create: (context) => getIt<ClientBloc>()),
      ],
      child: ValueListenableBuilder(
        valueListenable: themeNotifier,
        builder: (context, themeMode, child) {
          return MaterialApp(
            title: "RapidDrop",
            themeMode: themeMode,
            theme: theme.light(),
            darkTheme: theme.dark(),
            home: _getPlatformScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }

  Widget _getPlatformScreen() {
    // Check if running on Web
    if (kIsWeb) {
      return const ClientDashboardScreen();
    }

    // Check if running on Android
    if (!kIsWeb && Platform.isAndroid) {
      return const HostDashboardScreen();
    }

    // Unsupported platform
    return const UnsupportedPlatformScreen();
  }
}

class UnsupportedPlatformScreen extends StatelessWidget {
  const UnsupportedPlatformScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Unsupported Platform',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'This app only supports Android (as host) and Web (as client).',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
