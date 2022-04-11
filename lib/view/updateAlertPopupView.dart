import 'package:flutter/material.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/viewmodel/popupViewModel.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

class UpdateAlertBox extends StatefulWidget {
  final int alertId;
  final String alertName;
  final String alertCategory;
  final IconData iconData;
  const UpdateAlertBox({
    Key? key,
    required this.alertId,
    required this.alertName,
    required this.alertCategory,
    required this.iconData,
  }) : super(key: key);

  @override
  State<UpdateAlertBox> createState() => _UpdateAlertBoxState();
}

class _UpdateAlertBoxState extends State<UpdateAlertBox> {
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
        UPDATE_ALERT,
        style: homepageButtonTextStyle(),
        textAlign: TextAlign.right,
      ),
      actions: <Widget>[
        UpdateAlertNameTextField(
          nameController: nameController,
          alertName: widget.alertName,
        ),
        CategoryDropdown(
          onSelect: (String data) {
            selectedCategory = data;
          },
          alertCategory: widget.alertCategory,
        ),
        IconDropdown(
          onSelect: (IconData data) {
            selectedIcon = data;
          },
          iconData: widget.iconData,
          iconDropdownTitle: ALERT_ICON_UI,
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
                await updateAlertData(
                  widget.alertId,
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
