import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibe/commonCallbacks.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/view/addNewAlert.dart';
import 'package:vibe/view/buttonStyles.dart';
import 'package:vibe/view/savedAlerts.dart';
import 'package:vibe/view/settings.dart';
import 'package:vibe/view/appBar.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getPermissions();
      setDirectory();
      initCategoryList();
    });
  }

  //TODO: move all this to end of splash screen
  void getPermissions() async {
    await requestPermission(Permission.microphone);
    if (Platform.isAndroid) {
      await requestPermission(Permission.storage);
    } else {
      await requestPermission(Permission.mediaLibrary);
    }
  }

  Future<bool> setDirectory() async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory() as Directory;
          String newPath = "";
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "files") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = "$newPath/$RECORDINGS_FOLDER_NAME";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await requestPermission(Permission.mediaLibrary)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      //TODO: pathToRecordings needs to move out of audioRecorderModel
      setPathToRecordings(directory.path);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar("Vibe"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: handleNewRoute(context, const AddNewAlert()),
              child: Text(
                ADD_NEW_ALERT,
                style: mainButtonTextStyle(),
              ),
              style: mainButtonStyle(),
            ),
            ElevatedButton(
              onPressed: handleNewRoute(context, const SavedAlerts()),
              child: Text(
                SAVED_ALERTS,
                style: mainButtonTextStyle(),
              ),
              style: mainButtonStyle(),
            ),
            ElevatedButton(
              onPressed: handleNewRoute(context, const Settings()),
              child: Text(
                SETTINGS,
                style: mainButtonTextStyle(),
              ),
              style: mainButtonStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
