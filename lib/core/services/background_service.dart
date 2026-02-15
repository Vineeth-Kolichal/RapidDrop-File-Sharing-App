import 'dart:async';
import 'dart:ui';
import 'dart:io';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

@lazySingleton
class AppBackgroundService {
  Future<void> initialize() async {
    final service = FlutterBackgroundService();

    /// OPTIONAL, using custom notification channel id
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'file_sharing_server_v2', // id
      'File Sharing Server', // title
      description:
          'This channel is used for persistent notifications.', // description
      importance: Importance.high, // importance must be at low or higher level
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    if (Platform.isIOS || Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.initialize(
        settings: const InitializationSettings(
          iOS: DarwinInitializationSettings(),
          android: AndroidInitializationSettings('ic_launcher'),
        ),
      );
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        // This will be executed in the Dart isolate
        onStart: onStart,

        // auto start service
        autoStart: false,
        isForegroundMode: true,

        notificationChannelId: 'file_sharing_server_v2',
        initialNotificationTitle: 'RapidDrop Server',
        initialNotificationContent: 'Server is running in background',
        foregroundServiceNotificationId: 888,
        foregroundServiceTypes: [AndroidForegroundType.dataSync],
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: false,

        // this will be executed when app is in foreground in separated isolate
        onForeground: onStart,

        // you have to enable background fetch capability on xcode project
        onBackground: onIosBackground,
      ),
    );
  }

  Future<void> startService() async {
    final service = FlutterBackgroundService();
    if (!await service.isRunning()) {
      await service.startService();
    }
  }

  Future<void> stopService() async {
    final service = FlutterBackgroundService();
    if (await service.isRunning()) {
      service.invoke("stopService");
    }
  }

  Future<void> updateNotification({
    required String ip,
    required int port,
    required String pin,
  }) async {
    final service = FlutterBackgroundService();
    if (await service.isRunning()) {
      service.invoke("updateNotification", {
        "ip": ip,
        "port": port,
        "pin": pin,
      });
    }
  }
}

// this will be used as notification icon for android
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to 3.0.0
  // We have to register the plugin manually

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });

    service.on('updateNotification').listen((event) {
      if (event != null) {
        final ip = event['ip'];
        final port = event['port'];
        final pin = event['pin'];

        service.setForegroundNotificationInfo(
          title: "RapidDrop Server Active",
          content: "IP: $ip:$port | PIN: $pin",
        );
      }
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // Enable wakelock to keep the device awake
  // This is crucial for maintaining network connections in background
  try {
    WakelockPlus.enable();
  } catch (e) {
    print('Failed to enable wakelock: $e');
  }

  // bring to foreground
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        // Here you can update the notification content if needed
        // service.setForegroundNotificationInfo(
        //   title: "RapidDrop Server",
        //   content: "Server is active",
        // );
      }
    }
  });
}

// to ensure this is executed within the same isolate as the app
@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  // iOS background logic is limited, return true if successfully processed
  return true;
}
