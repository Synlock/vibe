import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:vibe/commonCalls.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/view/saveNewAlertDialog.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

class AudioRecorder extends StatefulWidget {
  const AudioRecorder({Key? key}) : super(key: key);

  @override
  State<AudioRecorder> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  final stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);
  final record = Record();
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    getMaxRecordTimeInSecs();
    getRecordButtonColor();
    getRecordButtonBorderRadius();
    getIsRecording();
  }

  @override
  void dispose() async {
    super.dispose();
    await stopWatchTimer.dispose();
    await record.dispose();
  }

  Future<void> startRecording(String path) async {
    try {
      if (await record.hasPermission()) {
        await record.start(path: path);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> stopRecording() async {
    final path = await record.stop();

    populateAlertsList(path);

    File jsonFile = await getJsonFile(ALERTS_JSON_FILE_NAME);
    encodeJson(
      jsonFile,
      getAlerts()!.map((e) => e.toJson()).toList(),
      FileMode.write,
    );
  }

  void executeStopWatch(
      StopWatchTimer stopWatchTimer, StopWatchExecute execute) {
    stopWatchTimer.onExecute.add(execute);
  }

  StreamBuilder<int> displayStopWatch(StopWatchTimer stopWatchTimer) {
    return StreamBuilder<int>(
      stream: stopWatchTimer.rawTime,
      initialData: stopWatchTimer.rawTime.value,
      builder: (context, snap) {
        final value = snap.data!;

        if (value >= getMaxRecordTimeInSecs() * 1000) stopRecord(context);

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

  Future<bool> saveAudio(String fileName) async {
    try {
      File saveFile = File(getPathToRecordings() + "/$fileName");
      if (!await saveFile.exists()) {
        saveFile.create();
      }
      startRecording(saveFile.path);
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  void startRecord() {
    int numberOfFiles = 0;
    try {
      Directory recordingsDirectory = Directory(getPathToRecordings());
      numberOfFiles = recordingsDirectory.listSync().length;
    } catch (e) {
      print(e);
    }
    //Resets Timer and then starts from 0
    executeStopWatch(stopWatchTimer, StopWatchExecute.reset);
    executeStopWatch(stopWatchTimer, StopWatchExecute.start);

    //Saves new recording
    saveAudio(numberOfFiles.toString() + NEW_RECORDING_NAME);

    //Recorder button turns into square
    setRecordButtonColor(Colors.black);
    setRecordButtonBorderRadius(BorderRadius.circular(5));
  }

  void stopRecord(BuildContext context) {
    //Stops the timer and stops the recording
    executeStopWatch(stopWatchTimer, StopWatchExecute.stop);
    stopRecording();

    //Recorder button turns back into a circle
    setRecordButtonColor(Colors.red);
    setRecordButtonBorderRadius(BorderRadius.circular(100));

    //TODO: allow to edit details in dialog box
    showDialog(
        context: context,
        builder: (context) {
          return const SaveNewAlertBox();
        });

    if (!getIsRecording()) return;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        setRecordButtonColor(Colors.red);
        setRecordButtonBorderRadius(BorderRadius.circular(100));
        setIsRecording(false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        displayStopWatch(stopWatchTimer),
        Container(
            //TODO: insert audio visualizer here
            ),
        AnimatedContainer(
          margin: const EdgeInsets.all(50.0),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.linearToEaseOut,
          decoration: BoxDecoration(
            color: getRecordButtonColor(),
            borderRadius: getRecordButtonBorderRadius(),
          ),
          child: IconButton(
            icon: const Icon(null),
            onPressed: () {
              setIsRecording(!getIsRecording());

              setState(() {
                if (getIsRecording()) {
                  startRecord();
                } else {
                  stopRecord(context);
                }
              });
            },
            iconSize: 50.0,
            color: getRecordButtonColor(),
          ),
        ),
      ],
    );
  }
}
