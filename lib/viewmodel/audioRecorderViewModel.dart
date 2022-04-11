import 'dart:io';

import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/model/audioRecorderModel.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/viewmodel/popupViewModel.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

int getMaxRecordTimeInSecs() => maxRecordTimeInSecs;
void setMaxRecordTimeInSecs(int newMaxRecordTime) =>
    maxRecordTimeInSecs = newMaxRecordTime;

Color? getRecordButtonColor() => recordButtonColor;
void setRecordButtonColor(Color? newColor) => recordButtonColor = newColor;

BorderRadius? getRecordButtonBorderRadius() => recordButtonBorderRadius;
void setRecordButtonBorderRadius(BorderRadius? newRadius) =>
    recordButtonBorderRadius = newRadius;

bool getIsRecording() => isRecording;
void setIsRecording(bool newIsRecording) => isRecording = newIsRecording;

String getPathToRecordings() => pathToRecordings;
void setPathToRecordings(String newPath) => pathToRecordings = newPath;

Future<void> startRecording(Record record, String path) async {
  try {
    if (await record.hasPermission()) {
      await record.start(path: path);

      Directory recordingsDirectory = Directory(getPathToRecordings());
      int alertIndex = 0;
      if (getAlerts()!.isEmpty) {
        alertIndex = 0;
      } else if (getAlerts()!.length == 1) {
        alertIndex = 1;
      } else {
        alertIndex = getAlerts()!.length;
      }
      getAlerts()!.add(AlertData(
          alertId: alertIndex,
          alertName: ALERT_NAME,
          alertCategory: DEFAULT,
          alertIcon: getAlertIcons[0].codePoint,
          alertDuration: 0,
          typeOfAlert: DEFAULT_ALERT_TYPE,
          isSilent: false,
          alertPath: recordingsDirectory.path));
    }
  } catch (e) {
    print(e);
  }
}

Future<void> stopRecording(Record record) async {
  final path = await record.stop();

  File jsonFile = await getJsonFile(ALERTS_JSON_FILE_NAME);
  await encodeJson(
    jsonFile,
    getAlerts()!.map((e) => e.toJson()).toList(),
    FileMode.write,
  );
}

void executeStopWatch(StopWatchTimer stopWatchTimer, StopWatchExecute execute) {
  stopWatchTimer.onExecute.add(execute);
}

Future<bool> saveAudio(Record record, String fileName) async {
  try {
    File saveFile = File(getPathToRecordings() + "/$fileName");
    if (!await saveFile.exists()) {
      saveFile.create();
    }
    startRecording(record, saveFile.path);
  } catch (e) {
    print(e);
    return false;
  }
  return false;
}

void startRecord(StopWatchTimer stopWatchTimer, Record record) {
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
  saveAudio(record, "${numberOfFiles.toString()}.wav");

  //Recorder button turns into square
  setRecordButtonColor(Colors.black);
  setRecordButtonBorderRadius(BorderRadius.circular(5));
}
