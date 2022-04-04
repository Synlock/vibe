import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:record/record.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:vibe/commonCalls.dart';
import 'package:vibe/model/audioRecorderModel.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/view/saveNewAlertDialog.dart';
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

int alertIndex = 0;
Future<void> populateAlertsList(String? path) async {
  final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
  Directory directory = Directory(getPathToRecordings());

  FileSystemEntity fileInDirectory = File("");
  for (var i = alertIndex; i < directory.listSync().length; i++) {
    if (fileInDirectory.path == path) break;
    fileInDirectory = directory.listSync()[i];

    String fullFileName = basename(fileInDirectory.path);

    if (getAlerts()!.isEmpty) {
      getAlerts()!.add(AlertData(
        alertId: json[0][ALERT_ID],
        alertName: json[0][ALERT_NAME],
        alertCategory: json[0][ALERT_CATEGORY],
        alertDuration: json[0][ALERT_DURATION],
        alertPath: fileInDirectory.path,
      ));
    } else {
      final item = json[i];
      getAlerts()!.add(AlertData(
        alertId: item[ALERT_ID],
        alertName: item[ALERT_NAME],
        alertCategory: item[ALERT_CATEGORY],
        alertDuration: item[ALERT_DURATION],
        alertPath: fileInDirectory.path,
      ));
    }
    alertIndex++;
  }
}

Future<void> startRecording(Record record, String path) async {
  try {
    if (await record.hasPermission()) {
      await record.start(path: path);
    }
  } catch (e) {
    print(e);
  }
}

Future<void> stopRecording(Record record) async {
  final path = await record.stop();

  populateAlertsList(path);

  File jsonFile = await getJsonFile(ALERTS_JSON_FILE_NAME);
  encodeJson(
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
  saveAudio(record, numberOfFiles.toString());

  //Recorder button turns into square
  setRecordButtonColor(Colors.black);
  setRecordButtonBorderRadius(BorderRadius.circular(5));
}
