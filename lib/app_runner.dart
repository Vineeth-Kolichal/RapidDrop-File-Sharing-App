import 'dart:async';
import 'package:file_sharing/core/services/sharedprefs_services.dart';
import 'package:file_sharing/core/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'package:flutter/foundation.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'core/api_endpoints/api_endpoints.dart';
import 'core/config/flavor_config.dart';
import 'core/dependency_injection/config/configure_injection.dart';

Future<void> runApplication(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig.initialize(flavor);
  await SharedPrefsServices.instance.initialize();

  if (!kIsWeb) {
    try {
      final info = NetworkInfo();
      final wifiIP = await info.getWifiIP();
      if (wifiIP != null && wifiIP.isNotEmpty) {
        ApiEndpoints.baseUrl = "http://$wifiIP:8080";
        debugPrint("Updated ApiEndpoints.baseUrl to ${ApiEndpoints.baseUrl}");
      }
    } catch (e) {
      debugPrint("Failed to get IP address: $e");
    }
  }

  _loadTheme();

  await configureInjection();
  runApp(MyApp());
}

Future<void> _loadTheme() async {
  final isDark = SharedPrefsServices.instance.getThemeMode();
  if (isDark != null) {
    themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
