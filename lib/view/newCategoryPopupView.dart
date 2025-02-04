import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/viewmodel/popupViewModel.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

class AddCategoryBox extends StatefulWidget {
  const AddCategoryBox({
    Key? key,
  }) : super(key: key);

  @override
  State<AddCategoryBox> createState() => _AddCategoryBoxState();
}

class _AddCategoryBoxState extends State<AddCategoryBox> {
  TextEditingController nameController = TextEditingController();
  IconData selectedIcon = getCategoryIcons[0];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding:
          const EdgeInsets.only(right: 18.0, bottom: 18.0, left: 18.0),
      title: Text(
        ADD_NEW_CATEGORY,
        style: homepageButtonTextStyle(),
        textAlign: TextAlign.right,
      ),
      actions: <Widget>[
        UpdateAlertNameTextField(
          nameController: nameController,
          alertName: NEW_CATEGORY_TEXT_HINT,
        ),
        IconDropdown(
          onSelect: (IconData data) {
            selectedIcon = data;
          },
          iconData: getCategoryIcons[0],
          iconDropdownTitle: CATEGORY_ICON_UI,
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
                File jsonFile = await getJsonFile(CATEGORY_JSON_FILE_NAME);
                getCategories()!.add(CategoryData(
                    categoryName: nameController.text,
                    categoryIcon: selectedIcon.codePoint));
                await encodeJson(
                  jsonFile,
                  getCategories()!.map((e) => e.toJson()).toList(),
                  FileMode.write,
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
