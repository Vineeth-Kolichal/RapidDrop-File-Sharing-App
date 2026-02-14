import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/local_server/presentation/pages/host_dashboard_screen.dart';
import '../../features/web_client/presentation/pages/client_dashboard_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          // Platform-based routing
          if (kIsWeb) {
            return const ClientDashboardScreen();
          }

          if (!kIsWeb && Platform.isAndroid) {
            return const HostDashboardScreen();
          }

          // Unsupported platform
          return const Scaffold(
            body: Center(
              child: Text(
                'Unsupported Platform\n\nThis app supports Android (host) and Web (client) only.',
              ),
            ),
          );
        },
      ),
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('Page not found'))),
  );
}
