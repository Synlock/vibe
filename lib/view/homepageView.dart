import 'dart:async';

import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:vibe/styles/buttons.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/styles/appBar.dart';
import 'package:vibe/view/addNewAlertView.dart';
import 'package:vibe/view/dataTaggingPopupView.dart';
import 'package:vibe/view/savedAlertsView.dart';
import 'package:vibe/view/settingsView.dart';
import 'package:vibe/viewmodel/listenStreamViewModel.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  IconData icon = Icons.square_rounded;
  Color iconColor = Colors.black;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      initSoundStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        MoveToBackground.moveTaskToBack();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: mainAppBar(context, "Vibe"),
        backgroundColor: indigoColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            homepageButton(
              context,
              const AddNewAlert(),
              ADD_NEW_ALERT,
              Icons.mic_rounded,
            ),
            homepageButton(
              context,
              const SavedAlerts(initialIndex: 1),
              SAVED_ALERTS,
              Icons.library_music,
            ),
            homepageButton(
              context,
              const Settings(),
              SETTINGS,
              Icons.settings,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showDataTaggingBox(context);
          },
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

void showDataTaggingBox(BuildContext context) async {
  var navigationResult = await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return const DataTaggingPopup(
        alertIcon: Icons.access_alarm,
        alertName: "Alarm",
      );
    },
  );
}
