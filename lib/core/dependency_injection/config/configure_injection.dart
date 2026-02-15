import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../services/background_service.dart';
import 'configure_injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureInjection() async {
  getIt.init(environment: Environment.prod);
  try {
    // Background Service
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      final service = getIt<AppBackgroundService>();
      await service.initialize();
    }
  } catch (e) {
    debugPrint("Failed to initialize background service: $e");
  }
}
