import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/styles/appBar.dart';
import 'package:vibe/view/saveNewAlertPopupView.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';
import 'package:vibe/viewmodel/initApplicationViewModel.dart';
import 'package:vibe/viewmodel/popupViewModel.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

class AddNewAlert extends StatefulWidget {
  const AddNewAlert({Key? key}) : super(key: key);

  @override
  State<AddNewAlert> createState() => _AddNewAlertState();
}

class _AddNewAlertState extends State<AddNewAlert> {
  final StopWatchTimer stopWatchTimer = StopWatchTimer();
  final Record record = Record();
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await getPermissions();
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await stopWatchTimer.dispose();
    await record.dispose();
  }

  StreamBuilder<int> displayStopWatch(
      StopWatchTimer stopWatchTimer, Record record) {
    return StreamBuilder<int>(
      stream: stopWatchTimer.rawTime,
      initialData: stopWatchTimer.rawTime.value,
      builder: (context, snap) {
        final value = snap.data!;

        if (value >= getMaxRecordTimeInSecs() * 1000) {
          stopRecord(context, stopWatchTimer, record);
          executeStopWatch(stopWatchTimer, StopWatchExecute.reset);
        }

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

  void stopRecord(BuildContext context, StopWatchTimer stopWatchTimer,
      Record record) async {
    //Stops the timer and stops the recording
    executeStopWatch(stopWatchTimer, StopWatchExecute.stop);
    stopRecording(record);

    //Recorder button turns back into a circle
    setRecordButtonColor(Colors.red);
    setRecordButtonBorderRadius(BorderRadius.circular(100));

    var navigationResults = await showDialog(
        context: context,
        builder: (context) {
          return SaveNewAlertBox(
            alertName: NEW_RECORDING_NAME,
            alertCategory: getCategories()![0].categoryName,
            iconData: getAlertIcons[0],
          );
        });
    if (navigationResults == null) {
      setState(() {
        AlertData addedAlert = getAlerts()!.last;
        if (addedAlert.alertName == ALERT_NAME) {
          int alertIndex = addedAlert.alertId;
          setAlertData(
              alertIndex,
              NEW_RECORDING_NAME + " " + alertIndex.toString(),
              DEFAULT,
              getAlertIcons[0]);
        }
      });
    }

    //if user settings not set to off start listening to mic after finish recording
    final json = await getDecodedJson(SETTINGS_JSON_FILE_NAME);
    if (!json[IS_SILENT]) {
      FlutterBackgroundService().invoke("streamRecorderController");
    }

    if (!getIsRecording()) return;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        setRecordButtonColor(Colors.red);
        setRecordButtonBorderRadius(BorderRadius.circular(100));
        setIsRecording(false);
      });
    });
  }

  int getDirectoryLength() {
    Directory recordingDir = Directory(getPathToRecordings());
    if (!recordingDir.existsSync()) {
      return 0;
    }
    int length = recordingDir.listSync().length;
    return length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, ADD_NEW_ALERT),
      backgroundColor: indigoColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //getIsRecording()?
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: RecorderWaveform(record: record),
              ),
              // : const InstructRecord(),
              getDirectoryLength() >= MAX_ALERTS
                  ? const Text(
                      "Too many alerts, please delete some, max = $MAX_ALERTS")
                  : RecorderWidget(
                      stopWatchTimer: stopWatchTimer,
                      record: record,
                      displayStopwatch: displayStopWatch,
                      stopRecord: stopRecord,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecorderWidget extends StatefulWidget {
  final StopWatchTimer stopWatchTimer;
  final Record record;
  final Function(StopWatchTimer, Record) displayStopwatch;
  final Function(BuildContext, StopWatchTimer, Record) stopRecord;

  const RecorderWidget({
    Key? key,
    required this.stopWatchTimer,
    required this.record,
    required this.displayStopwatch,
    required this.stopRecord,
  }) : super(key: key);

  @override
  State<RecorderWidget> createState() => _RecorderWidgetState();
}

class _RecorderWidgetState extends State<RecorderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.displayStopwatch(widget.stopWatchTimer, widget.record),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const IconButton(
              icon: Icon(null),
              onPressed: null,
              iconSize: 50,
              color: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              disabledColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  icon: AnimatedContainer(
                    width: 60,
                    height: 60,
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      color: getRecordButtonColor(),
                      borderRadius: getRecordButtonBorderRadius(),
                    ),
                  ),
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () async {
                    setIsRecording(!getIsRecording());
                    //await soundStreamer.stream.recorder.stop();
                    FlutterBackgroundService().invoke("stopRecorder");
                    setState(() {
                      if (getIsRecording()) {
                        startRecord(widget.stopWatchTimer, widget.record);
                      } else {
                        widget.stopRecord(
                            context, widget.stopWatchTimer, widget.record);
                      }
                    });
                  },
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.insert_drive_file),
              onPressed: () {
                Navigator.popAndPushNamed(context, SAVED_ALERTS_ROUTE);
              },
              iconSize: 50,
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}

class RecorderWaveform extends StatefulWidget {
  final Record record;

  const RecorderWaveform({
    Key? key,
    required this.record,
  }) : super(key: key);

  @override
  State<RecorderWaveform> createState() => _RecorderWaveformState();
}

class _RecorderWaveformState extends State<RecorderWaveform> {
  Amplitude amp = Amplitude(current: 0, max: 0);
  Timer ampTimer = Timer(Duration.zero, () {});
  double waveHeight = 0;

  @override
  void initState() {
    super.initState();

    ampTimer =
        Timer.periodic(const Duration(milliseconds: 200), (Timer t) async {
      if (!await widget.record.isRecording()) return;
      amp = await widget.record.getAmplitude();

      setState(() {
        waveHeight = amp.current == double.negativeInfinity
            ? 0
            : lerpDouble(200, 0, amp.current.abs() / 60)!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    ampTimer.cancel();
  }

  double getRandomMultiplier() {
    Random random = Random();

    double num = random.nextDouble() + 1.0;

    if (num == 0) num = 1;

    return num;
  }

  AnimatedContainer waveBar(double multiplier) => AnimatedContainer(
        duration: const Duration(milliseconds: 10),
        width: 35,
        height: waveHeight * multiplier,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        waveBar(getRandomMultiplier()),
        waveBar(getRandomMultiplier()),
        waveBar(getRandomMultiplier()),
        waveBar(1),
        waveBar(getRandomMultiplier()),
        waveBar(getRandomMultiplier()),
        waveBar(getRandomMultiplier()),
        waveBar(getRandomMultiplier()),
      ],
    );
  }
}

class InstructRecord extends StatelessWidget {
  const InstructRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          ADD_NEW_ALERT_INSTRUCTION_TEXT,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.end,
        ),
        Icon(
          Icons.touch_app,
          color: Colors.white,
          size: 70,
        ),
      ],
    );
  }
}
