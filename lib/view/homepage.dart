import 'package:flutter/material.dart';
import 'package:vibe/commonCallbacks.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/view/addNewAlert.dart';
import 'package:vibe/view/buttonStyles.dart';
import 'package:vibe/view/savedAlerts.dart';
import 'package:vibe/view/settings.dart';
import 'package:vibe/view/appBar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Vibe'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainTextButton(
                handleNewRoute(context, const AddNewAlert()), ADD_NEW_ALERT),
            MainTextButton(
                handleNewRoute(context, const SavedAlerts()), SAVED_ALERTS),
            MainTextButton(handleNewRoute(context, const Settings()), SETTINGS),
          ],
        ),
      ),
    );
  }
}
