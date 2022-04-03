import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

VoidCallback handleNewRoute(BuildContext context, Widget pageToRouteTo) {
  return (() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => pageToRouteTo,
      ),
    );
  });
}

Future<bool> requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
  }
  return false;
}

Future<Directory?> getPlatformDirectory() async {
  Directory directory;
  try {
    if (Platform.isAndroid) {
      if (await requestPermission(Permission.storage)) {
        directory = await getExternalStorageDirectory() as Directory;
      } else {
        return null;
      }
    } else {
      if (await requestPermission(Permission.mediaLibrary)) {
        directory = await getTemporaryDirectory();
      } else {
        return null;
      }
    }
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<File> getAlertsJsonFile() async {
  Directory? mainDir = await getPlatformDirectory();
  File jsonFile = File(mainDir!.path + "/" + "alertsList.json");

  //TODO: fix temporarily fill json with content to prevent decode error
  String contents =
      '[{"alertId":0,"alertName":"0 - New Recording","alertCategory":"Default","alertDuration":0}]';

  //TODO: need to call this on application start
  if (!await jsonFile.exists()) {
    await jsonFile.create();
    await jsonFile.writeAsString(contents);
  }

  return jsonFile;
}

void writeAlertsJson(File jsonFile) {
  String alertsJson = jsonEncode(getAlerts()!.map((e) => e.toJson()).toList());

  jsonFile.openWrite().write(alertsJson);
  jsonFile.openWrite().close();
}

Future<dynamic> decodedAlertsJson() async {
  File jsonFile = await getAlertsJsonFile();
  String jsonString = await jsonFile.readAsString();
  final json = jsonDecode(jsonString);
  return json;
}
