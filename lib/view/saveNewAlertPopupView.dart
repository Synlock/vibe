import 'package:flutter/material.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/view/savedAlertsView.dart';
import 'package:vibe/viewmodel/popupViewModel.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

class SaveNewAlertBox extends StatefulWidget {
  const SaveNewAlertBox({Key? key}) : super(key: key);

  @override
  State<SaveNewAlertBox> createState() => _SaveNewAlertBoxState();
}

class _SaveNewAlertBoxState extends State<SaveNewAlertBox> {
  TextEditingController nameController = TextEditingController();
  CategoryData selectedCategory = CategoryData(
    categoryName: getCategories()![0].categoryName,
  );
  //AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding:
          const EdgeInsets.only(right: 18.0, bottom: 18.0, left: 18.0),
      title: const Text(SAVE_NEW_ALERT),
      actions: <Widget>[
        AlertNameTextField(nameController: nameController),
        CategoryDropdown(
          onSelect: (CategoryData data) {
            selectedCategory = data;
          },
          alertCategory: selectedCategory,
        ),
        //Save Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              child: Text(
                SAVE,
                style: mainButtonTextStyle(),
              ),
              onPressed: () async {
                await setAlertData(nameController.text, selectedCategory);

                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SavedAlerts()),
                );
                Navigator.pop(context);
              },
              style: mainButtonStyle(),
            ),
            //Cancel Button
            ElevatedButton(
              child: Text(
                CANCEL,
                style: mainButtonTextStyle(),
              ),
              onPressed: () async {
                //TODO: create another popup with confirm delete
                //await setAlertData(NEW_RECORDING_NAME, DEFAULT, audioPlayer);
                Navigator.pop(context);
              },
              style: mainButtonStyle(),
            ),
          ],
        ),
      ],
    );
  }
}
