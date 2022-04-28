import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/styles/buttons.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/styles/appBar.dart';
import 'package:vibe/view/addNewAlertView.dart';
import 'package:vibe/view/savedAlertsView.dart';
import 'package:vibe/view/settingsView.dart';
import 'package:vibe/viewmodel/pushNotificationViewModel.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with WidgetsBindingObserver {
  IconData icon = Icons.square_rounded;
  Color iconColor = Colors.black;
  @override
  void initState() {
    super.initState();

    initNotificationActions(context);

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      final json = await getDecodedJson(SETTINGS_JSON_FILE_NAME);
      if (json[IS_SILENT]) {
        if (await FlutterBackgroundService().isRunning()) {
          FlutterBackgroundService().invoke("stopService");
        }
        return;
      }
      FlutterBackgroundService().invoke("initSoundStreamer");
    });
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    AwesomeNotifications().dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final bool isBackground = state == AppLifecycleState.paused;

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    if (isBackground) {
      //add code here for when back pressed from homepage or home button pressed
      //soundStreamer.stopRecorder();
      //FlutterBackgroundService().invoke("initSoundStreamer");
      return;
    }
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
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (builder) => const Homepage()));
        //   },
        //   child: const Text("Cancel"),
        // ),
      ),
    );
  }
}
