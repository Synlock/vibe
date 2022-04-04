import 'package:flutter/material.dart';
import 'package:vibe/commonCalls.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/view/appBar.dart';
import 'package:vibe/view/buttonStyles.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

class SavedAlerts extends StatefulWidget {
  const SavedAlerts({Key? key}) : super(key: key);

  @override
  State<SavedAlerts> createState() => _SavedAlertsState();
}

class _SavedAlertsState extends State<SavedAlerts> {
  List<Widget> alertBtnsWidgets = <Widget>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      addAlertsToPage(alertBtnsWidgets);
      print(getAlerts()!.length);
      print(alertBtnsWidgets.length);
    });
  }

  void addAlertsToPage(List<Widget> alertBtnsWidgets) {
    for (AlertData alert in getAlerts()!) {
      if (alertBtnsWidgets.length >= getAlerts()!.length) break;

      alertBtnsWidgets.add(AlertButton(alertName: alert.alertName));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(SAVED_ALERTS),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 50.0,
            runSpacing: 10.0,
            children: alertBtnsWidgets,
          ),
        ),
      ),
    );
  }
}

class AlertButton extends StatelessWidget {
  final String alertName;

  const AlertButton({Key? key, required this.alertName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(alertName, style: mainButtonTextStyle()),
        style: mainButtonStyle(),
      ),
    );
  }
}
