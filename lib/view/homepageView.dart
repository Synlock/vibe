import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:vibe/styles/buttons.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/styles/appBar.dart';
import 'package:vibe/view/addNewAlertView.dart';
import 'package:vibe/view/savedAlertsView.dart';
import 'package:vibe/view/settingsView.dart';
import 'package:vibe/viewmodel/micStreamViewModel.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  StartMicStreamState micStream = StartMicStreamState();
  IconData icon = Icons.square_rounded;
  Color iconColor = Colors.black;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      micStream.isRecording = true;
      micStream.controlMicStream(command: Command.start);
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
          onPressed: () {
            micStream.isRecording = !micStream.isRecording;

            if (micStream.isRecording) {
              micStream.controlMicStream(command: Command.start);
              icon = Icons.square_rounded;
              iconColor = Colors.black;
            } else {
              micStream.controlMicStream(command: Command.stop);
              icon = Icons.fiber_manual_record;
              iconColor = Colors.red;
            }
            setState(() {});
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
