import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/styles/buttons.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/viewmodel/popupViewModel.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

class UpdateCategoryBox extends StatefulWidget {
  final String categoryName;
  const UpdateCategoryBox({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<UpdateCategoryBox> createState() => _UpdateCategoryBoxState();
}

class _UpdateCategoryBoxState extends State<UpdateCategoryBox> {
  TextEditingController nameController = TextEditingController();
  IconData selectedIcon = getCategoryIcons[0];

  void deleteCategory() async {
    //Get the category to delete
    CategoryData categoryToDelete = getCategories()!
        .firstWhere((element) => element.categoryName == widget.categoryName);

    //Dont allow delete of default category
    if (categoryToDelete.categoryName == DEFAULT) return;

    //remove item from list
    getCategories()!
        .removeWhere((element) => element.categoryName == widget.categoryName);

    //Rewrite the categories json for saving
    File jsonFile = await getJsonFile(CATEGORY_JSON_FILE_NAME);
    await encodeJson(
      jsonFile,
      getCategories()!.map((e) => e.toJson()).toList(),
      FileMode.write,
    );

    //Rewrite all alerts that had that category with the default category
    File jsonFileAlerts = await getJsonFile(ALERTS_JSON_FILE_NAME);
    for (var i = 0; i < getAlerts()!.length; i++) {
      if (getAlerts()![i].alertCategory != categoryToDelete.categoryName) {
        continue;
      }
      getAlerts()![i].alertCategory = DEFAULT;
    }
    await encodeJson(
      jsonFileAlerts,
      getAlerts()!.map((e) => e.toJson()).toList(),
      FileMode.write,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding:
          const EdgeInsets.only(right: 18.0, bottom: 18.0, left: 18.0),
      title: Text(
        UPDATE_CATEGORY,
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
        //Delete Button
        Center(
          child: miniRoundedButton(
            () {
              deleteCategory();
              Navigator.pop(context);
            },
            DELETE,
          ),
        ),
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
                final json = await getDecodedJson(CATEGORY_JSON_FILE_NAME);
                updateCategoryData(
                    widget.categoryName, nameController.text, selectedIcon);
                await encodeJson(
                  jsonFile,
                  json,
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
