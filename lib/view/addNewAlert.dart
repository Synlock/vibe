import 'package:just_audio/just_audio.dart' as audio_player;
import 'package:flutter/material.dart';
import 'package:vibe/commonCalls.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/view/appBar.dart';
import 'package:vibe/view/audioRecorder.dart';
import 'package:vibe/view/styles.dart';
import 'package:vibe/view/savedAlerts.dart';

class AddNewAlert extends StatefulWidget {
  const AddNewAlert({Key? key}) : super(key: key);

  @override
  State<AddNewAlert> createState() => _AddNewAlertState();
}

class _AddNewAlertState extends State<AddNewAlert> {
  audio_player.AudioSource? audioSource;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(ADD_NEW_ALERT),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Expanded(
              flex: 8,
              child: AudioRecorder(),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 75.0),
                child: ElevatedButton(
                  onPressed: handleNewRoute(context, const SavedAlerts()),
                  child: Text(
                    SAVED_ALERTS,
                    style: mainButtonTextStyle(),
                  ),
                  style: mainButtonStyle(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
