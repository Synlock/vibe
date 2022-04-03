import 'package:flutter/material.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/view/appBar.dart';
import 'package:vibe/view/buttonStyles.dart';
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
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await initAlertsList();
      addAlertsToPage();
    });
  }

  List<Widget> addAlertsToPage() {
    for (var item in getAlerts()!) {
      if (alertBtnsWidgets.length >= getAlerts()!.length) break;
      alertBtnsWidgets.add(AlertButton(alertName: item.alertName));
    }
    setState(() {});
    return alertBtnsWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(SAVED_ALERTS),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 120.0,
              runSpacing: 10.0,
              children: alertBtnsWidgets,
            ),
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
    return ElevatedButton(
      onPressed: () {},
      child: Text(alertName, style: mainButtonTextStyle()),
      style: mainButtonStyle(),
    );
  }
}
