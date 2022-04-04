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

Future<File> getJsonFile(String fileName) async {
  Directory? mainDir = await getPlatformDirectory();
  File jsonFile = File(mainDir!.path + "/" + fileName);

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

Future<void> encodeJson(
    File jsonFile, dynamic objectToEncode, FileMode mode) async {
  String encodedJson = jsonEncode(objectToEncode);
  //jsonEncode(getAlerts()!.map((e) => e.toJson()).toList());

  await jsonFile.writeAsString(encodedJson, mode: mode);
}

Future<dynamic> getDecodedJson(String fileName) async {
  File jsonFile = await getJsonFile(fileName);
  String jsonString = await jsonFile.readAsString();
  final json = jsonDecode(jsonString);
  return json;
}
