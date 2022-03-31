import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as path;
import 'package:just_waveform/just_waveform.dart';
import 'package:flutter/material.dart';
import 'package:vibe/commonCallbacks.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/view/appBar.dart';
import 'package:vibe/view/buttonStyles.dart';
import 'package:vibe/view/savedAlerts.dart';

class AddNewAlert extends StatefulWidget {
  const AddNewAlert({Key? key}) : super(key: key);

  @override
  State<AddNewAlert> createState() => _AddNewAlertState();
}

class _AddNewAlertState extends State<AddNewAlert> {
  Color? color = Colors.red;
  BorderRadius radius = BorderRadius.circular(100);
  bool isRecording = false;

  final stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);

  @override
  void dispose() async {
    super.dispose();
    await stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(ADD_NEW_ALERT),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            displayStopWatch(stopWatchTimer),
            Container(
                //insert audio visualizer here
                ),
            AnimatedContainer(
              margin: const EdgeInsets.all(50.0),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.linearToEaseOut,
              decoration: BoxDecoration(
                color: color,
                borderRadius: radius,
              ),
              child: IconButton(
                icon: const Icon(null),
                onPressed: () {
                  //insert record function here
                  isRecording = !isRecording;

                  setState(() {
                    if (isRecording) {
                      executeStopWatch(stopWatchTimer, StopWatchExecute.start);
                      color = Colors.black;
                      radius = BorderRadius.zero;
                    } else {
                      executeStopWatch(stopWatchTimer, StopWatchExecute.stop);
                      color = Colors.red;
                      radius = BorderRadius.circular(100);
                    }
                  });
                },
                iconSize: 50.0,
                color: color,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 75.0),
                child: MainTextButton(
                    handleNewRoute(context, const SavedAlerts()),
                    SAVED_ALERTS)),
          ],
        ),
      ),
    );
  }
}

StreamBuilder<int> displayStopWatch(StopWatchTimer stopWatchTimer) {
  return StreamBuilder<int>(
    stream: stopWatchTimer.rawTime,
    initialData: stopWatchTimer.rawTime.value,
    builder: (context, snap) {
      final value = snap.data!;
      final displayTime = StopWatchTimer.getDisplayTime(value, hours: false);
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          displayTime,
          style: const TextStyle(
              fontSize: 40,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.bold),
        ),
      );
    },
  );
}

void executeStopWatch(StopWatchTimer stopWatchTimer, StopWatchExecute execute) {
  stopWatchTimer.onExecute.add(execute);
}
