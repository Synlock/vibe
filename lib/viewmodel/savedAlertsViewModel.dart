import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vibe/commonCalls.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';

List<AlertData>? getAlerts() => alerts;
List<CategoryData>? getCategories() => categories;

Future<void> initAlertsList() async {
  final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
  print(json);

  Directory directory = Directory(getPathToRecordings());
  // for (var i = 0; i < directory.listSync().length; i++) {
  //   if (alerts.length >= directory.listSync().length) break;
  for (var i = 0; i < getAlerts()!.length; i++) {
    if (i >= getAlerts()!.length) break;

    final item = json[i];
    getAlerts()!.add(
      AlertData(
        alertId: item[ALERT_ID],
        alertName: item[ALERT_NAME],
        alertCategory: item[ALERT_CATEGORY],
        alertDuration: item[ALERT_DURATION],
      ),
    );
  }
}

void initCategoryList() {
  categories.add(CategoryData(categoryId: 0, categoryName: "Default"));
  categories.add(CategoryData(categoryId: 1, categoryName: "Appliances"));
  categories.add(CategoryData(categoryId: 2, categoryName: "House Entrances"));
}

void populateCategoryList(CategoryData? newData) {
  categories.add(newData!);
}
