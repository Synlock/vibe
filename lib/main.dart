import 'package:flutter/material.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/view/addNewAlertView.dart';
import 'package:vibe/view/alertSettingsView.dart';
import 'package:vibe/view/homepageView.dart';
import 'package:vibe/view/savedAlertsView.dart';
import 'package:vibe/view/settingsView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vibe',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const Homepage(),
      initialRoute: '/',
      routes: {
        '/home': (context) => const Homepage(),
        '/newAlert': (context) => const AddNewAlert(),
        '/savedAlerts': (context) => const SavedAlerts(),
        '/alertSettings': (context) => AlertSettings(
              alertId: 0,
              alertName: "",
              alertIcon: const IconData(0),
              typeOfAlert: "",
              isSilenced: false,
              alertCategory: CategoryData(categoryName: ""),
            ),
        '/settings': (context) => const Settings(),
      },
    );
  }
}
