import 'package:flutter/material.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/view/addNewAlertView.dart';
import 'package:vibe/view/homepageView.dart';
import 'package:vibe/view/savedAlertsView.dart';
import 'package:vibe/view/settingsView.dart';
import 'package:vibe/view/splashScreenView.dart';

void main() {
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
        '/home': (context) => const Homepage(),
        '/newAlert': (context) => const AddNewAlert(),
        '/savedAlerts': (context) => const SavedAlerts(),
        '/settings': (context) => const Settings(),
      },
    );
  }
}
