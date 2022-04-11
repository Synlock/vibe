import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';
import 'package:vibe/viewmodel/popupViewModel.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

class InitApplication extends StatefulWidget {
  final AnimationController animationController;
  const InitApplication({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  @override
  State<InitApplication> createState() => _InitApplicationState();
}

class _InitApplicationState extends State<InitApplication> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      widget.animationController.stop();
      bool approved = await getPermissions();

      await setRecordingsDirectory();
      await initCategoryList();

      if (approved) {
        widget.animationController.forward();
      }

      Directory recordingsDir = Directory(getPathToRecordings());
      if (recordingsDir.listSync().isEmpty) return;

      await populateAlertsList("temp");
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.animationController.isCompleted
        ? CircularProgressIndicator.adaptive(
            backgroundColor: yellowColor,
          )
        : Container();
  }
}

Future<bool> getPermissions() async {
  bool micPermission = await requestPermission(Permission.microphone);
  if (micPermission) return true;
  if (Platform.isAndroid) {
    bool storagePermission = await requestPermission(Permission.storage);
    if (storagePermission) return true;
    return false;
  } else {
    bool mediaLibraryPermission =
        await requestPermission(Permission.mediaLibrary);
    if (mediaLibraryPermission) return true;
    return false;
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

Future<List<CategoryData>> initCategoryList() async {
  final File categoryJsonFile = await getJsonFile(CATEGORY_JSON_FILE_NAME);

  if (await categoryJsonFile.readAsString() == "") {
    getCategories()!.add(CategoryData(
      categoryName: DEFAULT,
      categoryIcon: getCategoryIcons[0].codePoint,
    ));
    getCategories()!.add(CategoryData(
      categoryName: HOME_CATEGORY_UI,
      categoryIcon: getCategoryIcons[1].codePoint,
    ));
    getCategories()!.add(CategoryData(
      categoryName: EMERGENCY_CATEGORY_UI,
      categoryIcon: getCategoryIcons[2].codePoint,
    ));

    try {
      await encodeJson(
        categoryJsonFile,
        getCategories()!.map((e) => e.toJson()).toList(),
        FileMode.write,
      );
    } catch (e) {
      print(e);
    }
  } else {
    final json = await getDecodedJson(CATEGORY_JSON_FILE_NAME);
    print(json);
    for (var i = 0; i < MAX_CATEGORIES; i++) {
      if (i >= json.length) break;

      var item = json[i];
      getCategories()!.add(CategoryData(
          categoryName: item[CATEGORY_NAME],
          categoryIcon: item[CATEGORY_ICON]));
    }
    await encodeJson(
      categoryJsonFile,
      getCategories()!.map((e) => e.toJson()).toList(),
      FileMode.write,
    );
  }
  return getCategories()!;
}
