import 'package:flutter/material.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/view/addNewAlertView.dart';
import 'package:vibe/view/homepageView.dart';
import 'package:vibe/view/savedAlertsView.dart';
import 'package:vibe/view/settingsView.dart';
import 'package:vibe/view/splashScreenView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        HOME_ROUTE: (context) => const Homepage(),
        NEW_ALERT_ROUTE: (context) => const AddNewAlert(),
        SAVED_ALERTS_ROUTE: (context) => const SavedAlerts(initialIndex: 1),
        SETTINGS_ROUTE: (context) => const Settings(),
      },
    );
  }
}
