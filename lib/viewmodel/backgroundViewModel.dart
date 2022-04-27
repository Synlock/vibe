import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:vibe/viewmodel/alertBehaviorViewModel.dart';
import 'package:vibe/viewmodel/pushNotificationViewModel.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

// to ensure this executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');
  //TODO: run soundstream here

  return true;
}

void onStart(ServiceInstance service) async {
  bool isActive = false;
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  service.on("cancelBehaviors").listen((event) {
    isActive = false;
  });

  //TODO: run soundstream here
  //initSoundStream();

  // bring to foreground
  Timer.periodic(
    const Duration(seconds: 1),
    (timer) async {
      if (service is AndroidServiceInstance) {
        await service.setForegroundNotificationInfo(
          title: "Listening for registered sounds",
          content: timer.tick.toString(),
        );
      }
    },
  );
  Timer.periodic(const Duration(seconds: 30), (timer) async {
    isActive = true;
    createCancelAlertNotification("Alert Name");
    vibrateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isActive) timer.cancel();
      print("vibrate");
      vibrateUntilCanceled();
    });

    flashTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isActive) timer.cancel();
      print("flash");

      flashUntilCancelled();
    });
  });
}
