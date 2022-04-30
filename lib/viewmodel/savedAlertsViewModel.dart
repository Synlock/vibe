import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/view/alertSettingsView.dart';
import 'package:vibe/view/savedAlertsByCategoryView.dart';
import 'package:vibe/view/savedAlertsView.dart';
import 'package:vibe/view/updateCategoryPopupView.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';
import 'package:vibe/viewmodel/popupViewModel.dart';

List<AlertData>? getAlerts() => alerts;
List<CategoryData>? getCategories() => categories;
List<AlertBehavior>? getAlertBehaviors() => alertBehaviors;

void initAlerts() async {
  getAlerts()!.addAll([
    AlertData(
      alertId: 0,
      alertName: RED_ALERT,
      alertCategory: EMERGENCY_CATEGORY_UI,
      alertIcon: getAlertIcons[2].codePoint,
      alertDuration: 0,
      alertPath: "",
      alertBehavior: AlertBehavior(
        isFullPage: false,
        isSound: false,
        isVibrate: true,
        isFlash: true,
        isSilent: false,
      ),
    ),
    AlertData(
      alertId: 1,
      alertName: SHOOTING,
      alertCategory: EMERGENCY_CATEGORY_UI,
      alertIcon: getAlertIcons[2].codePoint,
      alertDuration: 0,
      alertPath: "",
      alertBehavior: AlertBehavior(
        isFullPage: false,
        isSound: false,
        isVibrate: true,
        isFlash: true,
        isSilent: false,
      ),
    ),
    AlertData(
      alertId: 2,
      alertName: SIREN,
      alertCategory: EMERGENCY_CATEGORY_UI,
      alertIcon: getAlertIcons[2].codePoint,
      alertDuration: 0,
      alertPath: "",
      alertBehavior: AlertBehavior(
        isFullPage: false,
        isSound: false,
        isVibrate: true,
        isFlash: true,
        isSilent: false,
      ),
    ),
    AlertData(
      alertId: 3,
      alertName: DOORBELL,
      alertCategory: EMERGENCY_CATEGORY_UI,
      alertIcon: getAlertIcons[2].codePoint,
      alertDuration: 0,
      alertPath: "",
      alertBehavior: AlertBehavior(
        isFullPage: false,
        isSound: false,
        isVibrate: true,
        isFlash: true,
        isSilent: false,
      ),
    ),
    AlertData(
      alertId: 4,
      alertName: LOUD_SOUND,
      alertCategory: EMERGENCY_CATEGORY_UI,
      alertIcon: getAlertIcons[2].codePoint,
      alertDuration: 0,
      alertPath: "",
      alertBehavior: AlertBehavior(
        isFullPage: false,
        isSound: false,
        isVibrate: true,
        isFlash: true,
        isSilent: false,
      ),
    ),
    AlertData(
      alertId: 5,
      alertName: MICROWAVE,
      alertCategory: EMERGENCY_CATEGORY_UI,
      alertIcon: getAlertIcons[2].codePoint,
      alertDuration: 0,
      alertPath: "",
      alertBehavior: AlertBehavior(
        isFullPage: false,
        isSound: false,
        isVibrate: true,
        isFlash: true,
        isSilent: false,
      ),
    ),
    AlertData(
      alertId: 6,
      alertName: WASHING_MACHINE,
      alertCategory: EMERGENCY_CATEGORY_UI,
      alertIcon: getAlertIcons[2].codePoint,
      alertDuration: 0,
      alertPath: "",
      alertBehavior: AlertBehavior(
        isFullPage: false,
        isSound: false,
        isVibrate: true,
        isFlash: true,
        isSilent: false,
      ),
    ),
    AlertData(
      alertId: 7,
      alertName: DOOR_KNOCK,
      alertCategory: EMERGENCY_CATEGORY_UI,
      alertIcon: getAlertIcons[2].codePoint,
      alertDuration: 0,
      alertPath: "",
      alertBehavior: AlertBehavior(
        isFullPage: false,
        isSound: false,
        isVibrate: true,
        isFlash: true,
        isSilent: false,
      ),
    ),
  ]);
  final File jsonFile = await getJsonFile(ALERTS_JSON_FILE_NAME);
  final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
  await encodeJson(
      jsonFile, getAlerts()!.map((e) => e.toJson()).toList(), FileMode.write);
}

int alertIndex = 0;
Future<bool> populateAlertsList() async {
  try {
    final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);

    for (var i = 0; i < INITIAL_DEFAULT_ALERTS; i++) {
      final item = json[i];
      final alertBehavior = item[ALERT_BEHAVIOR];
      getAlerts()!.add(
        AlertData(
          alertId: item[ALERT_ID],
          alertName: item[ALERT_NAME],
          alertCategory: item[ALERT_CATEGORY],
          alertIcon: item[ALERT_ICON],
          alertDuration: 0, //item[ALERT_DURATION],
          alertPath: item[ALERT_PATH],
          alertBehavior: AlertBehavior(
            isFullPage: alertBehavior[IS_FULL_PAGE],
            isSound: alertBehavior[IS_SOUND],
            isVibrate: alertBehavior[IS_VIBRATE],
            isFlash: alertBehavior[IS_FLASH],
            isSilent: alertBehavior[IS_SILENT],
          ),
        ),
      );
    }

    Directory directory = Directory(getPathToRecordings());
    for (var i = alertIndex; i < directory.listSync().length; i++) {
      final item = json[i + INITIAL_DEFAULT_ALERTS];
      final alertBehavior = item[ALERT_BEHAVIOR];
      getAlerts()!.add(AlertData(
        alertId: item[ALERT_ID],
        alertName: item[ALERT_NAME],
        alertCategory: item[ALERT_CATEGORY],
        alertIcon: item[ALERT_ICON],
        alertDuration: 0, //item[ALERT_DURATION],
        alertPath: item[ALERT_PATH],
        alertBehavior: AlertBehavior(
          isFullPage: alertBehavior[IS_FULL_PAGE],
          isSound: alertBehavior[IS_SOUND],
          isVibrate: alertBehavior[IS_VIBRATE],
          isFlash: alertBehavior[IS_FLASH],
          isSilent: alertBehavior[IS_SILENT],
        ),
      ));
      alertIndex++;
    }
  } catch (e) {
    print(e);
  }
  return true;
}

Future<void> setAlertData(
  int alertId,
  String alertName,
  String alertCategory,
  IconData alertIcon,
) async {
  AlertData alertToChange = getAlerts()!.last;
  Directory recordingsDirectory = Directory(getPathToRecordings());
  //Duration? duration = await audioPlayer.setUrl(alertToChange.alertPath);

  alertToChange.alertId = alertId;
  if (alertName == "") {
    alertToChange.alertName =
        NEW_RECORDING_NAME + " " + alertToChange.alertId.toString();
  } else {
    alertToChange.alertName = alertName;
  }
  alertToChange.alertCategory = alertCategory;
  alertToChange.alertIcon = alertIcon.codePoint;
  //alertToChange.alertDuration = duration!.inSeconds;

  await renameAlertFile(
      "${recordingsDirectory.path}/${alertToChange.alertId}.wav",
      recordingsDirectory,
      alertToChange.alertName);

  alertToChange.alertPath =
      "${recordingsDirectory.path}/${alertToChange.alertName}.wav";

  setAlertBehaviorToDefault(alertToChange);

  File jsonFile = await getJsonFile(ALERTS_JSON_FILE_NAME);
  await encodeJson(
    jsonFile,
    getAlerts()!.map((e) => e.toJson()).toList(),
    FileMode.write,
  );
}

Future<void> updateAlertData(
    int alertId, String newName, String newCategory, IconData newIcon) async {
  Directory recordingsDirectory = Directory(getPathToRecordings());
  AlertData alertToChange = getAlerts()![alertId];

  //Duration? duration = await audioPlayer.setUrl(alertToChange.alertPath);
  if (newName != "") {
    await renameAlertFile(
        "${recordingsDirectory.path}/${alertToChange.alertName}.wav",
        recordingsDirectory,
        newName);

    alertToChange.alertName = newName;

    alertToChange.alertPath =
        "${recordingsDirectory.path}/${alertToChange.alertName}.wav";
  }

  if (newCategory != getCategories()![0].categoryName) {
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
}

Future<void> updateCategoryData(
    String categoryName, String newName, IconData newIcon) async {
  CategoryData categoryToChange = getCategories()!
      .firstWhere((element) => element.categoryName == categoryName);

  if (newName != "") {
    categoryToChange.categoryName = newName;
  }

  if (newIcon.codePoint != getCategoryIcons[0].codePoint) {
    categoryToChange.categoryIcon = newIcon.codePoint;
  }

  File jsonFile = await getJsonFile(CATEGORY_JSON_FILE_NAME);
  await encodeJson(
    jsonFile,
    getCategories()!.map((e) => e.toJson()).toList(),
    FileMode.write,
  );
}

void removeButtonsFromPage(List<Widget> buttonsList, void setState) {
  buttonsList.clear();
  setState;
}

void addAlertsToPage(List<Widget> alertBtnsWidgets, void setState) {
  for (AlertData alert in getAlerts()!) {
    if (alertBtnsWidgets.length >= getAlerts()!.length) break;
    alertBtnsWidgets.add(
      AlertButton(
        alertData: alert,
      ),
    );
  }
  setState;
}

void addCategoriesToPage(List<Widget> buttons, void setState) {
  for (CategoryData category in getCategories()!) {
    if (buttons.length >= getCategories()!.length) break;
    buttons.add(
      CategoryButton(
        categoryData: CategoryData(
          categoryName: category.categoryName,
          categoryIcon: category.categoryIcon,
        ),
      ),
    );
  }
  setState;
}

//loop through alerts list, find all with certain category and show buttons
findCategoryAlerts(List<Widget> buttons, String categoryName) {
  for (AlertData alert in getAlerts()!) {
    if (buttons.length >= getCategories()!.length) break;
    if (alert.alertCategory == categoryName) {
      buttons.add(AlertButton(alertData: alert));
    }
  }
}

void setAlertBehaviorToDefault(AlertData alert) {
  alert.alertBehavior.isFullPage = false;
  alert.alertBehavior.isSound = false;
  alert.alertBehavior.isVibrate = false;
  alert.alertBehavior.isFlash = false;
  alert.alertBehavior.isSilent = false;
}

TabBar upperTab(TabController controller, String categoryTabName) => TabBar(
      onTap: (value) {},
      controller: controller,
      tabs: <Tab>[
        Tab(text: categoryTabName),
        const Tab(text: ALL_UI),
      ],
    );
TabBarView upperTabViews(
  TabController controller,
  List<Widget> categoryBtns,
  List<Widget> alertBtns,
) =>
    TabBarView(
      controller: controller,
      children: [
        //Categories Page
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: categoryBtns,
            ),
          ),
        ),
        //All Page
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: alertBtns,
            ),
          ),
        ),
      ],
    );

void showUpdateCategoryBox(BuildContext context, String categoryName) async {
  var navigationResult = await showDialog(
      context: context,
      builder: (context) {
        return UpdateCategoryBox(
          categoryName: categoryName,
        );
      });
  if (navigationResult == null) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SavedAlerts(initialIndex: 0)));
  }
}

class AlertButton extends StatefulWidget {
  final AlertData alertData;

  const AlertButton({
    Key? key,
    required this.alertData,
  }) : super(key: key);

  @override
  State<AlertButton> createState() => _AlertButtonState();
}

class _AlertButtonState extends State<AlertButton> {
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlertSettings(
                alertId: widget.alertData.alertId,
                alertName: widget.alertData.alertName,
                alertIcon: IconData(widget.alertData.alertIcon,
                    fontFamily: 'MaterialIcons'),
                alertBehavior: widget.alertData.alertBehavior,
                alertCategory: widget.alertData.alertCategory,
                alertPath: widget.alertData.alertPath,
              ),
            ),
          ).then(onGoBack);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.alertData.alertName,
              style: mainButtonTextStyle(),
              textAlign: TextAlign.right,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Icon(
                IconData(widget.alertData.alertIcon,
                    fontFamily: 'MaterialIcons'),
                size: 60,
                color: indigoColor,
              ),
            ),
          ],
        ),
        style: mainButtonStyle(),
      ),
    );
  }
}

class CategoryButton extends StatefulWidget {
  final CategoryData categoryData;
  const CategoryButton({
    Key? key,
    required this.categoryData,
  }) : super(key: key);

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SavedAlertsByCategory(
                categoryData: widget.categoryData,
              ),
            ),
          );
        },
        onLongPress: () {
          showUpdateCategoryBox(
            context,
            widget.categoryData.categoryName,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.categoryData.categoryName,
              style: mainButtonTextStyle(),
              textAlign: TextAlign.right,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Icon(
                IconData(widget.categoryData.categoryIcon,
                    fontFamily: 'MaterialIcons'),
                size: 60,
                color: indigoColor,
              ),
            ),
          ],
        ),
        style: mainButtonStyle(),
      ),
    );
  }
}
