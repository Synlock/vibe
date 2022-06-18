import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/view/homepageView.dart';
import 'package:vibe/viewmodel/listenStreamViewModel.dart';

int createUniqueId() => DateTime.now().millisecondsSinceEpoch.remainder(100000);

void initNotificationActions(
    BuildContext context, String alertName, IconData alertIcon) {
  AwesomeNotifications().actionStream.listen((receivedAction) async {
    if (receivedAction.channelKey == CANCEL_ALERT_CHANNEL_KEY) {
      FlutterBackgroundService().invoke("cancelBehaviors");
      Timer(const Duration(minutes: 1), () {
        createDetectNotification("Alert Name");
      });
    } else if (receivedAction.channelKey == DETECT_ALERT_CHANNEL_KEY) {
      isActive = false;
      showDataTaggingBox(context, alertName, alertIcon);
    } else {}
  });
}

NotificationChannel cancelAlertChannel = NotificationChannel(
  channelKey: CANCEL_ALERT_CHANNEL_KEY,
  channelName: CANCEL_ALERT_CHANNEL_NAME,
  channelDescription: 'Notification channel for cancelling alerts',
  importance: NotificationImportance.High,
  defaultColor: const Color(0xFF9D50DD),
  ledColor: Colors.white,
  channelShowBadge: true,
  locked: true,
);
NotificationChannel detectAlertChannel = NotificationChannel(
  channelKey: DETECT_ALERT_CHANNEL_KEY,
  channelName: DETECT_ALERT_CHANNEL_NAME,
  channelDescription: 'Notification channel for cancelling alerts',
  importance: NotificationImportance.High,
  defaultColor: const Color(0xFF9D50DD),
  ledColor: Colors.white,
  channelShowBadge: true,
  locked: true,
);

void createCancelAlertNotification(String alertName) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: CANCEL_ALERT_CHANNEL_KEY,
      title: alertName,
      body: "Press to cancel alert",
      wakeUpScreen: true,
      notificationLayout: NotificationLayout.Default,
    ),
    // actionButtons: <NotificationActionButton>[
    //   NotificationActionButton(
    //     key: "cancel_alert",
    //     label: "Cancel Alert",
    //     buttonType: ActionButtonType.DisabledAction,
    //   ),
    // ],
  );
}

void createDetectNotification(String alertName) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: DETECT_ALERT_CHANNEL_KEY,
      title: CORRECT_DETECTION,
      body: alertName,
      wakeUpScreen: true,
      notificationLayout: NotificationLayout.Default,
    ),
    // actionButtons: <NotificationActionButton>[
    //   NotificationActionButton(key: "cancel_alert", label: "Cancel Alert"),
    // ],
  );
}
