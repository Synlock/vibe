import 'package:flutter/material.dart';
import 'package:vibe/view/appBar.dart';

class SavedAlerts extends StatefulWidget {
  const SavedAlerts({Key? key}) : super(key: key);

  @override
  State<SavedAlerts> createState() => _SavedAlertsState();
}

class _SavedAlertsState extends State<SavedAlerts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar("Saved Alerts"),
    );
  }
}
