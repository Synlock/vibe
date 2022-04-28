import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/styles/buttons.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/styles/appBar.dart';
import 'package:vibe/viewmodel/initApplicationViewModel.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //TODO:// move functions to viewmodel
  bool isSilent = false;
  bool isSilentFrom = false;
  int hour = 0;
  int min = 0;
  bool isDoNotDisturb = false;
  bool isSync = false;
  bool isSaveHistory = false;

  final service = FlutterBackgroundService();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      bool havePermissions = await getPermissions();
      if (!havePermissions) return;

      try {
        final json = await getDecodedJson(SETTINGS_JSON_FILE_NAME);
        setState(() {
          isSilent = json[IS_SILENT];
          isSilentFrom = json[IS_SILENT_FROM];
          min = json[TIME_TO_SILENCE_MINUTE];
          hour = json[TIME_TO_SILENCE_HOUR];
          isSync = json[IS_SYNC];
          isDoNotDisturb = json[IS_DO_NOT_DISTURB];
        });
      } catch (e) {
        print(e);
      }
    });
  }

  Future<void> updateSettingsBools(String valueToUpdate, bool newValue) async {
    final jsonFile = await getJsonFile(SETTINGS_JSON_FILE_NAME);
    final json = await getDecodedJson(SETTINGS_JSON_FILE_NAME);
    json[valueToUpdate] = newValue;

    await encodeJson(jsonFile, json, FileMode.write);
  }

  void setIsSilent(bool value) async {
    bool isBgServiceRunning = await service.isRunning();
    if (!isSilent) {
      service.invoke("stopRecorder");
      if (isBgServiceRunning) {
        //service.invoke("stopService");
      }
      setState(() {
        isSilent = true;
      });
    } else {
      service.invoke("streamRecorderController");
      if (!isBgServiceRunning) {
        await service.startService();
      }
      setState(() {
        isSilent = false;
      });
    }
    await updateSettingsBools(IS_SILENT, isSilent);
  }

  void setIsSilenceFrom(bool value) async {
    if (!isSilentFrom) {
      setState(() {
        isSilentFrom = true;
        //insert silence alarm here
      });
    } else {
      setState(() {
        isSilentFrom = false;
        //insert silence off alarm here
      });
    }
    await updateSettingsBools(IS_SILENT_FROM, isSilentFrom);
  }

  void setIsDoNotDisturb(bool value) async {
    if (!isDoNotDisturb) {
      setState(() {
        isDoNotDisturb = true;
        //insert silence alarm here
      });
    } else {
      setState(() {
        isDoNotDisturb = false;
        //insert silence off alarm here
      });
    }
    await updateSettingsBools(IS_DO_NOT_DISTURB, isDoNotDisturb);
  }

  void setIsSync(bool value) async {
    if (!isSync) {
      setState(() {
        isSync = true;
        //insert silence alarm here
      });
    } else {
      setState(() {
        isSync = false;
        //insert silence off alarm here
      });
    }
    await updateSettingsBools(IS_SYNC, isSync);
  }

  // void setIsSaveHistory(bool value) async{
  //   if (!isSaveHistory) {
  //     setState(() {
  //       isSaveHistory = true;
  //       //insert silence alarm here
  //     });
  //   } else {
  //     setState(() {
  //       isSaveHistory = false;
  //       //insert silence off alarm here
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, SETTINGS),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 250,
                color: indigoColor,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 85.0),
                child: Icon(
                  Icons.cloud_upload_rounded,
                  size: 100,
                  color: yellowColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  SAVE_TO_CLOUD,
                  style: saveCloudTextStyle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 125.0),
                child: roundedButton(
                  () {},
                  SIGN_UP_SIGN_IN_TEXT,
                ),
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  alertButton(
                    () {},
                    DEFAULT_ALERT_TYPE,
                    VIBRATE, //<<make this arg dynamic
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    alertButtonStyle()!,
                  ),
                  divider(),
                  toggleButton(
                    IS_SILENT,
                    "",
                    isSilent,
                    setIsSilent,
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    settingsButtonStyle()!,
                  ),
                  divider(),
                  toggleButton(
                    SILENCE_FROM_TIME,
                    "$hour:$min",
                    isSilentFrom,
                    setIsSilenceFrom,
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    settingsButtonStyle()!,
                  ),
                  divider(),
                  toggleButton(
                    DO_NOT_DISTURB,
                    ONLY_EMERGENCY_ALERTS, //<<make this arg dynamic
                    isDoNotDisturb,
                    setIsDoNotDisturb,
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    settingsButtonStyle()!,
                  ),
                  divider(),
                  toggleButton(
                    SYNC_WITH_OTHER_DEVICES,
                    SYNC_SUBTEXT,
                    isSync,
                    setIsSync,
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    settingsButtonStyle()!,
                  ),
                  // divider(),
                  // toggleButton(
                  //   SAVE_ALERT_HISTORY,
                  //   "",
                  //   isSaveHistory,
                  //   setIsSaveHistory,
                  //   alertButtonTextStyle()!,
                  //   subAlertButtonTextStyle()!,
                  //   settingsButtonStyle()!,
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
