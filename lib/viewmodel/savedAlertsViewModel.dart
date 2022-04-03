import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';

List<AlertData>? getAlerts() => alerts;
List<CategoryData>? getCategories() => categories;

void initAlertsList() {
  Directory directory = Directory(getPathToRecordings());
  for (var i = 0; i < directory.listSync().length; i++) {
    if (alerts!.length >= directory.listSync().length) continue;

    alerts!.add(AlertData(i, "$i$NEW_RECORDING_NAME", getCategories()![0], ""));
  }
}

void initCategoryList() {
  categories?.add(CategoryData(0, "Default"));
  categories?.add(CategoryData(1, "Appliances"));
  categories?.add(CategoryData(2, "House Entrances"));
}

void populateCategoryList(CategoryData? newData) {
  categories?.add(newData!);
}
