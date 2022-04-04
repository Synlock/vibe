import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:vibe/commonCalls.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

import '../model/audioRecorderModel.dart';

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
    final item = json[i];
    fileInDirectory = directory.listSync()[i];

    String fullFileName = basename(fileInDirectory.path);

    if (getAlerts()!.isEmpty) {
      getAlerts()!.add(AlertData(
        alertId: json[0][ALERT_ID],
        alertName: json[0][ALERT_NAME],
        alertCategory: json[0][ALERT_CATEGORY],
        alertDuration: json[0][ALERT_DURATION],
        alertPath: json[0][ALERT_PATH],
      ));
    } else {
      getAlerts()!.add(AlertData(
        alertId: item[ALERT_ID],
        alertName: item[ALERT_NAME],
        alertCategory: item[ALERT_CATEGORY],
        alertDuration: item[ALERT_DURATION],
        alertPath: item[ALERT_PATH],
      ));
    }
    alertIndex++;
  }
}
