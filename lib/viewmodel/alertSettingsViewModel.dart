import 'package:flutter/material.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/styles/styles.dart';

List<String>? getAlertTypes() => <String>[
      VIBRATE,
      MEDIUM,
      FLASHLIGHT_STROBE,
      BANNER,
    ];

class AlertTypeDropdown extends StatefulWidget {
  Function(String) onSelect;
  String alertType;
  AlertTypeDropdown({
    Key? key,
    required this.onSelect,
    required this.alertType,
  }) : super(key: key);

  @override
  State<AlertTypeDropdown> createState() => _AlertTypeDropdownState();
}

class _AlertTypeDropdownState extends State<AlertTypeDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7.0),
            child: DropdownButton<String>(
              value: widget.alertType,
              items: getAlertTypeDropdown(),
              onChanged: (String? newValue) {
                setState(() {
                  widget.alertType = newValue!;
                  widget.onSelect(widget.alertType);
                });
              },
            ),
          ),
          Text(
            TYPE_OF_ALERT_UI,
            style: alertDropdownTextStyle(),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> getAlertTypeDropdown() {
    return getAlertTypes()!
        .map((e) => DropdownMenuItem<String>(
              child: Text(e),
              value: e,
            ))
        .toList();
  }
}
