import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';

//TODO: move all this to end of splash screen
//TODO: make sure recording directory is created on first app run
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
