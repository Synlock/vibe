import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

List<IconData> getAlertIcons = [
  Icons.access_alarm_rounded,
  Icons.door_back_door_outlined,
  Icons.sensors_rounded,
  Icons.add,
  Icons.taxi_alert_outlined
];
List<IconData> getCategoryIcons = [
  Icons.access_alarm_rounded,
  Icons.door_back_door_outlined,
  Icons.sensors_rounded,
  Icons.add,
  Icons.taxi_alert_outlined
];

class CategoryDropdown extends StatefulWidget {
  Function(String) onSelect;
  String alertCategory;
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
        DropdownButton<String>(
          value: widget.alertCategory,
          items: getCategoryDropdown(),
          onChanged: (String? newValue) {
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

  List<DropdownMenuItem<String>> getCategoryDropdown() {
    return getCategories()!
        .map((e) => DropdownMenuItem<String>(
              child: Text(e.categoryName),
              value: e.categoryName,
            ))
        .toList();
  }
}

class UpdateAlertNameTextField extends StatefulWidget {
  final TextEditingController nameController;
  final String alertName;
  const UpdateAlertNameTextField({
    Key? key,
    required this.nameController,
    required this.alertName,
  }) : super(key: key);

  @override
  State<UpdateAlertNameTextField> createState() =>
      _UpdateAlertNameTextFieldState();
}

class _UpdateAlertNameTextFieldState extends State<UpdateAlertNameTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.right,
      controller: widget.nameController,
      maxLength: 25,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: InputDecoration(
        hintText: widget.alertName,
      ),
    );
  }
}

class IconDropdown extends StatefulWidget {
  Function(IconData) onSelect;
  IconData iconData;
  String iconDropdownTitle;
  IconDropdown({
    Key? key,
    required this.onSelect,
    required this.iconData,
    required this.iconDropdownTitle,
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
          widget.iconDropdownTitle,
          style: alertButtonTextStyle(),
        ),
      ],
    );
  }
}
