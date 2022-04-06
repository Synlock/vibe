import 'dart:io';

import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart';
import 'package:vibe/commonCalls.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';

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

    if (fileInDirectory.path == path || i >= directory.listSync().length) break;

    if (i == 0) {
      getAlerts()!.add(AlertData(
        alertId: 0,
        alertName: json[0][ALERT_NAME],
        alertCategory: json[0][ALERT_CATEGORY],
        alertDuration: 0, //json[0][ALERT_DURATION],
        alertPath: directory.listSync()[0].path,
        typeOfAlert: '',
        isSilent: false,
      ));
    } else {
      final item = json[i];
      print(item);
      getAlerts()!.add(AlertData(
        alertId: item[ALERT_ID],
        alertName: item[ALERT_NAME],
        alertCategory: item[ALERT_CATEGORY],
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
Future<void> setAlertData(String alertName, String categoryName) async {
  AlertData alertToChange = getAlerts()![getAlerts()!.length - 1];
  String newName = alertName;
  String newCategory = categoryName;
  //Duration? duration = await audioPlayer.setUrl(alertToChange.alertPath);
  alertToChange.alertId = getAlerts()!.length - 1;
  alertToChange.alertName = newName;
  alertToChange.alertCategory = newCategory;
  //alertToChange.alertDuration = duration!.inSeconds;
  alertToChange.alertPath =
      Directory(getPathToRecordings()).listSync()[getAlerts()!.length - 1].path;

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
