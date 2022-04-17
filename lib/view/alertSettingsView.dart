import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/styles/buttons.dart';
import 'package:vibe/styles/appBar.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/view/alertBannerView.dart';
import 'package:vibe/view/confirmDeletePopupView.dart';
import 'package:vibe/view/updateAlertPopupView.dart';

class AlertSettings extends StatefulWidget {
  int alertId;
  String alertName;
  IconData alertIcon;
  AlertBehavior alertBehavior;
  String alertCategory;
  String alertPath;
  AlertSettings({
    Key? key,
    required this.alertId,
    required this.alertName,
    required this.alertIcon,
    required this.alertBehavior,
    required this.alertCategory,
    required this.alertPath,
  }) : super(key: key);

  @override
  State<AlertSettings> createState() => _AlertSettingsState();
}

class _AlertSettingsState extends State<AlertSettings> {
  final _player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
      final item = json[widget.alertId];
      setState(() {
        //widget.alertBehavior = item[TYPE_OF_ALERT][];
      });
    });
  }

  void setFullPageToggle(bool value) async {
    File jsonFile = await getJsonFile(ALERTS_JSON_FILE_NAME);
    final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
    final item = json[widget.alertId][ALERT_BEHAVIOR];
    if (!widget.alertBehavior.isFullPage) {
      setState(() {
        widget.alertBehavior.isFullPage = true;
        item[IS_FULL_PAGE] = widget.alertBehavior.isFullPage;
      });
    } else {
      setState(() {
        widget.alertBehavior.isFullPage = false;
        item[IS_FULL_PAGE] = widget.alertBehavior.isFullPage;
      });
    }
    await encodeJson(jsonFile, json, FileMode.write);
  }

  void setSoundToggle(bool value) async {
    File jsonFile = await getJsonFile(ALERTS_JSON_FILE_NAME);
    final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
    final item = json[widget.alertId][ALERT_BEHAVIOR];
    if (!widget.alertBehavior.isSound) {
      setState(() {
        widget.alertBehavior.isSound = true;
        item[IS_SOUND] = widget.alertBehavior.isSound;
      });
    } else {
      setState(() {
        widget.alertBehavior.isSound = false;
        item[IS_SOUND] = widget.alertBehavior.isSound;
      });
    }
    await encodeJson(jsonFile, json, FileMode.write);
  }

  void setVibrateToggle(bool value) async {
    File jsonFile = await getJsonFile(ALERTS_JSON_FILE_NAME);
    final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
    final item = json[widget.alertId][ALERT_BEHAVIOR];
    if (!widget.alertBehavior.isVibrate) {
      setState(() {
        widget.alertBehavior.isVibrate = true;
        item[IS_VIBRATE] = widget.alertBehavior.isVibrate;
      });
    } else {
      setState(() {
        widget.alertBehavior.isVibrate = false;
        item[IS_VIBRATE] = widget.alertBehavior.isVibrate;
      });
    }
    await encodeJson(jsonFile, json, FileMode.write);
  }

  void setFlashToggle(bool value) async {
    File jsonFile = await getJsonFile(ALERTS_JSON_FILE_NAME);
    final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
    final item = json[widget.alertId][ALERT_BEHAVIOR];
    if (!widget.alertBehavior.isFlash) {
      setState(() {
        widget.alertBehavior.isFlash = true;
        item[IS_FLASH] = widget.alertBehavior.isFlash;
      });
    } else {
      setState(() {
        widget.alertBehavior.isFlash = false;
        item[IS_FLASH] = widget.alertBehavior.isFlash;
      });
    }
    await encodeJson(jsonFile, json, FileMode.write);
  }

  void setSilenceToggle(bool value) async {
    File jsonFile = await getJsonFile(ALERTS_JSON_FILE_NAME);
    final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
    final item = json[widget.alertId][ALERT_BEHAVIOR];
    if (!widget.alertBehavior.isSilent) {
      setState(() {
        widget.alertBehavior.isSilent = true;
        item[IS_SILENT] = widget.alertBehavior.isSilent;
      });
    } else {
      setState(() {
        widget.alertBehavior.isSilent = false;
        item[IS_SILENT] = widget.alertBehavior.isSilent;
      });
    }
    await encodeJson(jsonFile, json, FileMode.write);
  }

  void showAlertDetailsBox() async {
    var navigationResult = await showDialog(
        context: context,
        builder: (context) {
          return UpdateAlertBox(
            alertId: widget.alertId,
            alertName: widget.alertName,
            alertCategory: widget.alertCategory,
            iconData: widget.alertIcon,
          );
        });
    if (navigationResult == null) {
      final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
      final item = json[widget.alertId];
      setState(() {
        widget.alertName = item[ALERT_NAME];
        widget.alertIcon =
            IconData(item[ALERT_ICON], fontFamily: 'MaterialIcons');
        widget.alertCategory = item[ALERT_CATEGORY];
      });
    }
  }

  void showConfirmDeleteBox() async {
    var navigationResult = await showDialog(
        context: context,
        builder: (context) {
          return ConfirmDeleteAlertBox(
            alertId: widget.alertId,
            alertName: widget.alertName,
          );
        });
    if (navigationResult == null) {
      setState(() {});
    }
  }

  void showAlertBox() async {
    var navigationResult = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertPopup(
            alert: AlertData(
              alertId: widget.alertId,
              alertName: widget.alertName,
              alertCategory: widget.alertCategory,
              alertIcon: widget.alertIcon.codePoint,
              alertDuration: 0,
              alertPath: widget.alertPath,
              alertBehavior: widget.alertBehavior,
            ),
          );
        });
    if (navigationResult == null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: mainAppBar(context, ALERT),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 210,
                            color: indigoColor,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 65.0),
                              child: iconTextStackButton(
                                showAlertDetailsBox,
                                widget.alertName,
                                widget.alertIcon,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  alertButton(
                    () async {
                      await _player.setAudioSource(
                          AudioSource.uri(Uri.parse(widget.alertPath)));
                      await _player.play();
                    },
                    PLAY,
                    "",
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    alertButtonStyle()!,
                  ),
                  divider(),
                  alertButton(
                    () async {
                      widget.alertBehavior.isFullPage
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AlertBanner(
                                        alert: AlertData(
                                          alertId: widget.alertId,
                                          alertName: widget.alertName,
                                          alertCategory: widget.alertCategory,
                                          alertIcon: widget.alertIcon.codePoint,
                                          alertDuration: 0,
                                          alertPath: widget.alertPath,
                                          alertBehavior: widget.alertBehavior,
                                        ),
                                      )),
                            )
                          : showAlertBox();
                    },
                    "Show alert banner",
                    "",
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    alertButtonStyle()!,
                  ),
                  divider(),
                  toggleButton(
                    IS_FULL_PAGE_UI,
                    "",
                    widget.alertBehavior.isFullPage,
                    setFullPageToggle,
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    alertButtonStyle()!,
                  ),
                  divider(),
                  toggleButton(
                    IS_SOUND_UI,
                    "",
                    widget.alertBehavior.isSound,
                    setSoundToggle,
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    alertButtonStyle()!,
                  ),
                  divider(),
                  toggleButton(
                    IS_VIBRATE_UI,
                    "",
                    widget.alertBehavior.isVibrate,
                    setVibrateToggle,
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    alertButtonStyle()!,
                  ),
                  divider(),
                  toggleButton(
                    IS_FLASH_UI,
                    "",
                    widget.alertBehavior.isFlash,
                    setFlashToggle,
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    alertButtonStyle()!,
                  ),
                  divider(),
                  toggleButton(
                    SILENCE_THIS_ALERT_UI,
                    "",
                    widget.alertBehavior.isSilent,
                    setSilenceToggle,
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    alertButtonStyle()!,
                  ),
                  divider(),
                  alertButton(
                    () {},
                    UPDATE_THIS_ALERT_UI,
                    RERECORD,
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    alertButtonStyle()!,
                  ),
                  divider(),
                  alertButton(
                    () {},
                    CATEGORY_UI,
                    widget.alertCategory,
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    alertButtonStyle()!,
                  ),
                  divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: FractionallySizedBox(
                      widthFactor: 0.35,
                      child: miniRoundedButton(
                        () {
                          showConfirmDeleteBox();
                        },
                        DELETE,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
