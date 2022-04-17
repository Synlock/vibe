import 'package:flutter/material.dart';
import 'package:vibe/styles/buttons.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/styles/appBar.dart';
import 'package:vibe/viewmodel/listenStreamViewModel.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //TODO:// move functions to viewmodel
  bool isSilent = true;
  bool isSilenceFrom = true;
  bool isDoNotDisturb = true;
  bool isSync = false;
  bool isSaveHistory = false;

  void setIsSilent(bool value) async {
    if (!isSilent) {
      stream1RecorderController();
      setState(() {
        isSilent = true;
      });
    } else {
      stopRecorders();
      setState(() {
        isSilent = false;
      });
    }
  }

  void setIsSilenceFrom(bool value) {
    if (!isSilenceFrom) {
      setState(() {
        isSilenceFrom = true;
        //insert silence alarm here
      });
    } else {
      setState(() {
        isSilenceFrom = false;
        //insert silence off alarm here
      });
    }
  }

  void setIsDoNotDisturb(bool value) {
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
  }

  void setIsSync(bool value) {
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
  }

  void setIsSaveHistory(bool value) {
    if (!isSaveHistory) {
      setState(() {
        isSaveHistory = true;
        //insert silence alarm here
      });
    } else {
      setState(() {
        isSaveHistory = false;
        //insert silence off alarm here
      });
    }
  }

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
                    "23:00",
                    isSilenceFrom,
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
                  divider(),
                  toggleButton(
                    SAVE_ALERT_HISTORY,
                    "",
                    isSaveHistory,
                    setIsSaveHistory,
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    settingsButtonStyle()!,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
