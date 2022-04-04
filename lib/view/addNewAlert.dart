import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:vibe/commonCalls.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/view/appBar.dart';
import 'package:vibe/view/audioRecorder.dart';
import 'package:vibe/view/saveNewAlertDialog.dart';
import 'package:vibe/view/styles.dart';
import 'package:vibe/view/savedAlerts.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';

class AddNewAlert extends StatefulWidget {
  const AddNewAlert({Key? key}) : super(key: key);

  @override
  State<AddNewAlert> createState() => _AddNewAlertState();
}

class _AddNewAlertState extends State<AddNewAlert> {
  final stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);
  final record = Record();
  final audioPlayer = AudioPlayer();

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

  void stopRecord(
      BuildContext context, StopWatchTimer stopWatchTimer, Record record) {
    //Stops the timer and stops the recording
    executeStopWatch(stopWatchTimer, StopWatchExecute.stop);
    stopRecording(record);

    //Recorder button turns back into a circle
    setRecordButtonColor(Colors.red);
    setRecordButtonBorderRadius(BorderRadius.circular(100));

    showDialog(
        context: context,
        builder: (context) {
          return const SaveNewAlertBox();
        });

    if (!getIsRecording()) return;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState() {
        setRecordButtonColor(Colors.red);
        setRecordButtonBorderRadius(BorderRadius.circular(100));
        setIsRecording(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(ADD_NEW_ALERT),
      backgroundColor: indigoColor,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 25.0),
              child: Text(
                ADD_NEW_ALERT_INSTRUCTION_TEXT,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(25.0),
              child: Icon(
                Icons.touch_app,
                color: Colors.white,
                size: 70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: displayStopWatch(stopWatchTimer, record),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.stop),
                    onPressed: () {},
                    iconSize: 50,
                    color: Colors.grey,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.fiber_manual_record),
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          setIsRecording(!getIsRecording());

                          setState(() {
                            if (getIsRecording()) {
                              startRecord(stopWatchTimer, record);
                            } else {
                              stopRecord(context, stopWatchTimer, record);
                            }
                          });
                        },
                        iconSize: 75,
                        color: getRecordButtonColor(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.insert_drive_file),
                    onPressed: handleNewRoute(context, const SavedAlerts()),
                    iconSize: 50,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
