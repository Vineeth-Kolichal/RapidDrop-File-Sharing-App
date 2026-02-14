import 'dart:async';
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

  await configureInjection();
  runApp(MyApp());
}
