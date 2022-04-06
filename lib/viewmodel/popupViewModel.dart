import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

List<IconData> getAlertIcons = [
  Icons.access_alarm_rounded,
  Icons.door_back_door_outlined,
  Icons.sensors_rounded,
  Icons.add,
  Icons.taxi_alert_outlined
];

class CategoryDropdown extends StatefulWidget {
  Function(CategoryData) onSelect;
  CategoryData alertCategory;
  CategoryDropdown({
    Key? key,
    required this.onSelect,
    required this.alertCategory,
  }) : super(key: key);

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton<CategoryData>(
          value: widget.alertCategory,
          items: getCategoryDropdown(),
          onChanged: (CategoryData? newValue) {
            setState(() {
              widget.alertCategory = newValue!;
              widget.onSelect(widget.alertCategory);
            });
          },
        ),
        Text(
          CATEGORY,
          style: alertButtonTextStyle(),
        ),
      ],
    );
  }

  List<DropdownMenuItem<CategoryData>> getCategoryDropdown() {
    return getCategories()!
        .map((e) => DropdownMenuItem<CategoryData>(
              child: Text(e.categoryName),
              value: e,
            ))
        .toList();
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
      textAlign: TextAlign.end,
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

class IconDropdown extends StatefulWidget {
  Function(IconData) onSelect;
  IconData iconData;
  IconDropdown({
    Key? key,
    required this.onSelect,
    required this.iconData,
  }) : super(key: key);

  @override
  State<IconDropdown> createState() => _IconDropdownState();
}

class _IconDropdownState extends State<IconDropdown> {
  List<DropdownMenuItem<IconData>> getIconDropdown() {
    return getAlertIcons
        .map((e) => DropdownMenuItem<IconData>(
              child: Icon(e),
              value: e,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton<IconData>(
          value: widget.iconData,
          items: getIconDropdown(),
          onChanged: (IconData? newValue) {
            setState(() {
              widget.iconData = newValue!;
              widget.onSelect(widget.iconData);
            });
          },
        ),
        Text(
          ALERT_ICON_UI,
          style: alertButtonTextStyle(),
        ),
      ],
    );
  }
}
