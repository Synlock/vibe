import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vibe/commonCalls.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/tags.dart';

List<AlertData>? getAlerts() => alerts;
List<CategoryData>? getCategories() => categories;

Future<void> initAlertsList() async {
  final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
  print(json);
  for (var i = 0; i < getAlerts()!.length; i++) {
    final item = json[i];
    getAlerts()!.add(
      AlertData(
        alertId: item[ALERT_ID],
        alertName: item[ALERT_NAME],
        alertCategory: item[ALERT_CATEGORY],
        alertDuration: item[ALERT_DURATION],
        alertPath: item[ALERT_PATH],
      ),
    );
  }
}

//TODO: fix if delete file cannot record anymore, problem when getting files in directory to JSON
Future<void> setAlertData(TextEditingController nameController,
    String categoryName, AudioPlayer audioPlayer) async {
  AlertData alertToChange = getAlerts()![getAlerts()!.length - 1];
  String newName = nameController.text;
  String newCategory = categoryName;
  Duration? duration = await audioPlayer.setUrl(alertToChange.alertPath);

  alertToChange.alertName = newName;
  alertToChange.alertCategory = newCategory;
  alertToChange.alertDuration = duration!.inSeconds;

  File jsonFile = await getJsonFile(ALERTS_JSON_FILE_NAME);
  await encodeJson(
    jsonFile,
    getAlerts()!.map((e) => e.toJson()).toList(),
    FileMode.write,
  );
}

void initCategoryList() {
  categories.add(CategoryData(categoryId: 0, categoryName: "Default"));
  categories.add(CategoryData(categoryId: 1, categoryName: "Appliances"));
  categories.add(CategoryData(categoryId: 2, categoryName: "House Entrances"));
}

void populateCategoryList(CategoryData? newData) {
  categories.add(newData!);
}
