import 'dart:io';

import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/styles/buttons.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/styles/appBar.dart';
import 'package:vibe/view/addNewAlertView.dart';
import 'package:vibe/view/savedAlertsView.dart';
import 'package:vibe/view/settingsView.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';
import 'package:vibe/viewmodel/micStreamViewModel.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  StartMicStreamState micStream = StartMicStreamState();
  IconData icon = Icons.square_rounded;
  Color iconColor = Colors.black;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await getPermissions();
      await setRecordingsDirectory();
      initCategoryList();
      micStream.isRecording = true;
      micStream.controlMicStream(command: Command.start);
      Directory recordingsDir = Directory(getPathToRecordings());
      if (recordingsDir.listSync().isEmpty) return;

      await populateAlertsList(
          "${recordingsDir.path}/${recordingsDir.listSync().length}");
      print(getAlerts()!.length);
    });
  }

  //TODO: move all this to end of splash screen
  //TODO: make sure recording directory is created on first app run
  Future<void> getPermissions() async {
    await requestPermission(Permission.microphone);
    if (Platform.isAndroid) {
      await requestPermission(Permission.storage);
    } else {
      await requestPermission(Permission.mediaLibrary);
    }
  }

  Future<bool> setRecordingsDirectory() async {
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        MoveToBackground.moveTaskToBack();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: mainAppBar(context, "Vibe"),
        backgroundColor: indigoColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            homepageButton(
              context,
              const AddNewAlert(),
              ADD_NEW_ALERT,
              Icons.mic_rounded,
            ),
            homepageButton(
              context,
              const SavedAlerts(),
              SAVED_ALERTS,
              Icons.library_music,
            ),
            homepageButton(
              context,
              const Settings(),
              SETTINGS,
              Icons.settings,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            micStream.isRecording = !micStream.isRecording;

            if (micStream.isRecording) {
              micStream.controlMicStream(command: Command.start);
              icon = Icons.square_rounded;
              iconColor = Colors.black;
            } else {
              micStream.controlMicStream(command: Command.stop);
              icon = Icons.fiber_manual_record;
              iconColor = Colors.red;
            }

            setState(() {});
          },
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
