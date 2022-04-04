import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:vibe/view/saveNewAlertDialog.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';

class AudioRecorder extends StatefulWidget {
  const AudioRecorder({Key? key}) : super(key: key);

  @override
  State<AudioRecorder> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  @override
  void initState() {
    super.initState();
    getMaxRecordTimeInSecs();
    getRecordButtonColor();
    getRecordButtonBorderRadius();
    getIsRecording();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // displayStopWatch(stopWatchTimer, record),
  @override
  Widget build(BuildContext context) {
    return Container(
        //TODO: insert audio visualizer here
        );
  }
}
        // AnimatedContainer(
        //   margin: const EdgeInsets.all(50.0),
        //   duration: const Duration(milliseconds: 1000),
        //   curve: Curves.linearToEaseOut,
        //   decoration: BoxDecoration(
        //     color: getRecordButtonColor(),
        //     borderRadius: getRecordButtonBorderRadius(),
        //   ),
        //   child: IconButton(
        //     icon: const Icon(null),
        //     onPressed: () {
        //       setIsRecording(!getIsRecording());

        //       setState(() {
        //         if (getIsRecording()) {
        //           startRecord(stopWatchTimer, record);
        //         } else {
        //           stopRecord(context, stopWatchTimer, record);
        //         }
        //       });
        //     },
        //     iconSize: 50.0,
        //     color: getRecordButtonColor(),
        //   ),
        // ),
