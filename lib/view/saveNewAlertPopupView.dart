import 'package:flutter/material.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/view/updateAlertPopupView.dart';
import 'package:vibe/viewmodel/popupViewModel.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

class SaveNewAlertBox extends StatefulWidget {
  final String alertName;
  final String alertCategory;
  final IconData iconData;

  const SaveNewAlertBox({
    Key? key,
    required this.alertName,
    required this.alertCategory,
    required this.iconData,
  }) : super(key: key);

  @override
  State<SaveNewAlertBox> createState() => _SaveNewAlertBoxState();
}

class _SaveNewAlertBoxState extends State<SaveNewAlertBox> {
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
        ADD_NEW_ALERT,
        style: homepageButtonTextStyle(),
        textAlign: TextAlign.right,
      ),
      actions: <Widget>[
        UpdateAlertNameTextField(
          nameController: nameController,
          alertName: "Add new alert name here",
        ),
        CategoryDropdown(
          onSelect: (String data) {
            selectedCategory = data;
          },
          alertCategory: selectedCategory,
        ),
        IconDropdown(
          onSelect: (IconData data) {
            selectedIcon = data;
          },
          iconData: selectedIcon,
        ),
        //Save Button
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              child: Text(
                SAVE,
                style: popupTextStyle(),
              ),
              //Save Button
              onPressed: () async {
                await setAlertData(
                  nameController.text,
                  selectedCategory,
                  selectedIcon,
                );
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
                //TODO: create another popup with confirm delete
                //await setAlertData(NEW_RECORDING_NAME, DEFAULT, audioPlayer);
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
