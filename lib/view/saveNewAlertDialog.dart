import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/view/buttonStyles.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

class SaveNewAlertBox extends StatefulWidget {
  const SaveNewAlertBox({Key? key}) : super(key: key);

  @override
  State<SaveNewAlertBox> createState() => _SaveNewAlertBoxState();
}

class _SaveNewAlertBoxState extends State<SaveNewAlertBox> {
  TextEditingController nameController = TextEditingController();
  CategoryData selectedCategory = CategoryData(
      categoryId: getCategories()![0].categoryId,
      categoryName: getCategories()![0].categoryName);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding:
          const EdgeInsets.only(right: 18.0, bottom: 18.0, left: 18.0),
      title: const Text("Saving New Alert"),
      actions: <Widget>[
        AlertNameTextField(nameController: nameController),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
          child: CategoryDropdown(onSelect: (CategoryData data) {
            selectedCategory = data;
          }),
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
              onPressed: () {
                //TODO: add Save Function
                //nameController.text; << value of alert name input
                //selectedCategory.categoryName; << value of selected category
                //handleNewRoute(context, const SavedAlerts());
              },
              style: mainButtonStyle(),
            ),
            //Cancel Button
            ElevatedButton(
              child: Text(
                CANCEL,
                style: mainButtonTextStyle(),
              ),
              onPressed: () {
                //create another popup with confirm delete
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

class CategoryDropdown extends StatefulWidget {
  final Function(CategoryData) onSelect;
  const CategoryDropdown({Key? key, required this.onSelect}) : super(key: key);

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  CategoryData dropdownValue = getCategories()![0];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Category:"),
        DropdownButton<CategoryData>(
          value: dropdownValue,
          items: getCategories()!
              .map((e) => DropdownMenuItem<CategoryData>(
                    child: Text(e.categoryName),
                    value: e,
                  ))
              .toList(),
          onChanged: (CategoryData? newValue) {
            setState(() {
              dropdownValue = newValue!;
              widget.onSelect(dropdownValue);
            });
          },
        ),
      ],
    );
  }
}

class AlertNameTextField extends StatefulWidget {
  final TextEditingController nameController;
  const AlertNameTextField({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  @override
  State<AlertNameTextField> createState() => _AlertNameTextFieldState();
}

class _AlertNameTextFieldState extends State<AlertNameTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.nameController,
      maxLength: 25,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: const InputDecoration(
        labelText: "Alert Name",
        hintText: "New Recording",
        helperText: "ie. Microwave end beep",
      ),
    );
  }
}
