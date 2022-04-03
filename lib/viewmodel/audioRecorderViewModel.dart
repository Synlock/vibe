import 'package:flutter/material.dart';

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
