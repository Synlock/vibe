import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:vibe/model/savedAlertsModel.dart';
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
void populateAlertsList(String? path) {
  Directory directory = Directory(getPathToRecordings());

  FileSystemEntity fileInDirectory = File("");
  for (var i = alertIndex; i < directory.listSync().length; i++) {
    if (fileInDirectory.path == path) break;

    fileInDirectory = directory.listSync()[i];

    String fullFileName = basename(fileInDirectory.path);
    //Duration? duration = await audioPlayer.setUrl(directory.path);

    if (getAlerts()!.isEmpty) {
      getAlerts()!.add(AlertData(
          alertId: 0,
          alertName: fullFileName,
          alertCategory: getCategories()![0].categoryName,
          alertDuration: 0));
    } else {
      if (alertIndex == getAlerts()![i].alertId) continue;

      getAlerts()!.add(AlertData(
          alertId: i,
          alertName: fullFileName,
          alertCategory: getCategories()![0].categoryName,
          alertDuration: 0));
    }
    alertIndex++;
  }
}
