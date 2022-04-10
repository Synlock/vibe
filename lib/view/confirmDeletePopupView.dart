import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';
import 'package:vibe/viewmodel/popupViewModel.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

class ConfirmDeleteAlertBox extends StatefulWidget {
  final int alertId;
  const ConfirmDeleteAlertBox({
    Key? key,
    required this.alertId,
  }) : super(key: key);

  @override
  State<ConfirmDeleteAlertBox> createState() => _ConfirmDeleteAlertBoxState();
}

class _ConfirmDeleteAlertBoxState extends State<ConfirmDeleteAlertBox> {
  TextEditingController nameController = TextEditingController();
  String selectedCategory = getCategories()![0].categoryName;
  IconData selectedIcon = getAlertIcons[0];
  //AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding:
          const EdgeInsets.only(right: 18.0, bottom: 18.0, left: 18.0),
      title: Text(
        DELETE_ALERT,
        style: homepageButtonTextStyle(),
        textAlign: TextAlign.right,
      ),
      actions: <Widget>[
        //Save Button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text(
                CONFIRM,
                style: popupTextStyle(),
              ),
              //Delete Button
              onPressed: () async {
                Directory recordingsDirectory =
                    Directory(getPathToRecordings());
                final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
                final item = json[widget.alertId];

                File f =
                    File("${recordingsDirectory.path}/${item[ALERT_ID]}.wav");
                await f.delete();

                getAlerts()!.remove(getAlerts()![widget.alertId]);

                Navigator.pop(context);
              },
              style: popupButtonStyle(),
            ),
            //Cancel Button
            ElevatedButton(
              child: Text(
                CANCEL,
                style: popupTextStyle(),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              style: popupButtonStyle(),
            ),
          ],
        ),
      ],
    );
  }
}
