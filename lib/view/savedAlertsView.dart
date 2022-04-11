import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/misc/tags.dart';
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
      removeAlertsFromPage(alertBtnsWidgets);
      addAlertsToPage(alertBtnsWidgets);
    });
  }

  void addAlertsToPage(List<Widget> alertBtnsWidgets) {
    for (AlertData alert in getAlerts()!) {
      if (alertBtnsWidgets.length >= getAlerts()!.length) break;
      alertBtnsWidgets.add(
        AlertButton(
          alertData: alert,
        ),
      );
    }
    setState(() {});
  }

  void removeAlertsFromPage(List<Widget> alertBtnsWidgets) {
    alertBtnsWidgets.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, SAVED_ALERTS),
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
          onPressed: () {
            Navigator.popAndPushNamed(context, "/newAlert");
          },
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

class AlertButton extends StatefulWidget {
  final AlertData alertData;

  const AlertButton({
    Key? key,
    required this.alertData,
  }) : super(key: key);

  @override
  State<AlertButton> createState() => _AlertButtonState();
}

class _AlertButtonState extends State<AlertButton> {
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlertSettings(
                alertId: widget.alertData.alertId,
                alertName: widget.alertData.alertName,
                alertIcon: IconData(widget.alertData.alertIcon,
                    fontFamily: 'MaterialIcons'),
                typeOfAlert: widget.alertData.typeOfAlert,
                isSilenced: widget.alertData.isSilent,
                alertCategory: widget.alertData.alertCategory,
                alertPath: widget.alertData.alertPath,
              ),
            ),
          ).then(onGoBack);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.alertData.alertName,
              style: mainButtonTextStyle(),
              textAlign: TextAlign.right,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Icon(
                IconData(widget.alertData.alertIcon,
                    fontFamily: 'MaterialIcons'),
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
