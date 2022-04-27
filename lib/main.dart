import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/view/addNewAlertView.dart';
import 'package:vibe/view/homepageView.dart';
import 'package:vibe/view/savedAlertsView.dart';
import 'package:vibe/view/settingsView.dart';
import 'package:vibe/view/splashScreenView.dart';
import 'package:vibe/viewmodel/backgroundViewModel.dart';
import 'package:vibe/viewmodel/pushNotificationViewModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService(); //<-- initializes background service
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    //'resource://drawable/res_app_icon',
    null,
    [
      cancelAlertChannel,
      detectAlertChannel,
    ],
    debug: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: VIBE,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const SplashScreen(),
      initialRoute: '/',
      routes: {
        SPLASH_ROUTE: (context) => const SplashScreen(),
        HOME_ROUTE: (context) => const Homepage(),
        NEW_ALERT_ROUTE: (context) => const AddNewAlert(),
        SAVED_ALERTS_ROUTE: (context) => const SavedAlerts(initialIndex: 1),
        SETTINGS_ROUTE: (context) => const Settings(),
      },
    );
  }
}
