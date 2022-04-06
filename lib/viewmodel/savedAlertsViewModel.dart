import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';
import 'package:vibe/viewmodel/popupViewModel.dart';

List<AlertData>? getAlerts() => alerts;
List<CategoryData>? getCategories() => categories;

int alertIndex = 0;
Future<void> populateAlertsList(String? path) async {
  File jsonFile = await getJsonFile(ALERTS_JSON_FILE_NAME);
  final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
  print(json);
  Directory directory = Directory(getPathToRecordings());

  FileSystemEntity fileInDirectory = File("");
  for (var i = alertIndex; i < directory.listSync().length; i++) {
    fileInDirectory = directory.listSync()[i];

    if (fileInDirectory.path == path) break;

    if (i == 0) {
      getAlerts()!.add(AlertData(
        alertId: 0,
        alertName: "alertName",
        alertCategory: CategoryData(categoryName: DEFAULT),
        alertIcon: 0,
        alertDuration: 0, //json[0][ALERT_DURATION],
        alertPath: directory.listSync()[0].path,
        typeOfAlert: 'type',
        isSilent: false,
      ));
    } else {
      final item = json[i];
      print(item);
      getAlerts()!.add(AlertData(
        alertId: item[ALERT_ID],
        alertName: item[ALERT_NAME],
        alertCategory: item[ALERT_CATEGORY],
        alertIcon: item[ALERT_ICON],
        alertDuration: 0, //item[ALERT_DURATION],
        alertPath: fileInDirectory.path,
        typeOfAlert: '',
        isSilent: false,
      ));
    }
    alertIndex++;
  }
  await encodeJson(
    jsonFile,
    getAlerts()!.map((e) => e.toJson()).toList(),
    FileMode.write,
  );
}

//TODO: fix if delete file cannot record anymore, problem when getting files in directory to JSON
Future<void> setAlertData(
  String alertName,
  CategoryData alertCategory,
//  IconData alertIcon,
) async {
  AlertData alertToChange = getAlerts()![getAlerts()!.length - 1];
  //Duration? duration = await audioPlayer.setUrl(alertToChange.alertPath);

  alertToChange.alertId = getAlerts()!.length - 1;
  alertToChange.alertName = alertName;
  alertToChange.alertCategory = alertCategory;
  alertToChange.alertIcon = getAlertIcons[3].codePoint;
  //alertToChange.alertDuration = duration!.inSeconds;
  alertToChange.alertPath =
      Directory(getPathToRecordings()).listSync()[getAlerts()!.length - 1].path;
  alertToChange.typeOfAlert = MEDIUM;
  alertToChange.isSilent = false;

  File jsonFile = await getJsonFile(ALERTS_JSON_FILE_NAME);
  await encodeJson(
    jsonFile,
    getAlerts()!.map((e) => e.toJson()).toList(),
    FileMode.write,
  );
}

Future<void> updateAlertData(int alertId, String newName,
    CategoryData newCategory, IconData newIcon) async {
  AlertData alertToChange = getAlerts()![alertId];

  //Duration? duration = await audioPlayer.setUrl(alertToChange.alertPath);
  if (newName != "") {
    alertToChange.alertName = newName;
  }

  if (newCategory != getCategories()![0]) {
    alertToChange.alertCategory = newCategory;
  }

  if (newIcon.codePoint != getAlertIcons[0].codePoint) {
    alertToChange.alertIcon = newIcon.codePoint;
  }
  //alertToChange.alertDuration = duration!.inSeconds;

  File jsonFile = await getJsonFile(ALERTS_JSON_FILE_NAME);
  await encodeJson(
    jsonFile,
    getAlerts()!.map((e) => e.toJson()).toList(),
    FileMode.write,
  );
  final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
  print(json);
}

void initCategoryList() {
  categories.add(CategoryData(categoryName: DEFAULT));
  categories.add(CategoryData(categoryName: HOME_CATEGORY_UI));
  categories.add(CategoryData(categoryName: EMERGENCY_CATEGORY_UI));
}

void populateCategoryList(CategoryData? newData) {
  categories.add(newData!);
}
