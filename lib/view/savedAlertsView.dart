import 'package:flutter/material.dart';
import 'package:vibe/commonCalls.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/view/addNewAlertView.dart';
import 'package:vibe/styles/appBar.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/view/alertSettingsView.dart';
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
      final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
      print(json);
      addAlertsToPage(alertBtnsWidgets);
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: alertBtnsWidgets,
          ),
        ),
      ),
      floatingActionButton: Transform.scale(
        scale: 1.15,
        child: FloatingActionButton(
          onPressed: handleNewRoute(context, const AddNewAlert()),
          backgroundColor: yellowColor,
          isExtended: true,
          child: Icon(
            Icons.add,
            color: indigoColor,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

//TODO: make icon dynamic based off of category
class AlertButton extends StatelessWidget {
  final String alertName;

  const AlertButton({Key? key, required this.alertName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: handleNewRoute(context, const AlertSettings()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              alertName,
              style: mainButtonTextStyle(),
              textAlign: TextAlign.right,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Icon(
                Icons.access_alarm,
                size: 60,
                color: indigoColor,
              ),
            ),
          ],
        ),
        style: mainButtonStyle(),
      ),
    );
  }
}
