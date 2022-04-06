import 'package:flutter/material.dart';
import 'package:vibe/styles/buttons.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/styles/appBar.dart';
import 'package:vibe/styles/styles.dart';

class AlertSettings extends StatefulWidget {
  const AlertSettings({Key? key}) : super(key: key);

  @override
  State<AlertSettings> createState() => _AlertSettingsState();
}

//TODO: make all elements dynamic by pulling data from JSON
class _AlertSettingsState extends State<AlertSettings> {
  bool isOn = false;
  void setToggle(bool value) {
    if (!isOn) {
      setState(() {
        isOn = true;
        //insert silence alarm here
      });
    } else {
      setState(() {
        isOn = false;
        //insert silence off alarm here
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(ALERT),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 250,
                color: indigoColor,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Icon(
                  Icons.sensors_rounded,
                  size: 100,
                  color: yellowColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Text(
                  "Red Alert", //<< Dynamic alert name here
                  style: homepageButtonTextStyle(),
                ),
              ),
            ],
          ),
          Column(
            children: [
              alertButton(
                TYPE_OF_ALERT_UI,
                VIBRATE,
                alertButtonTextStyle()!,
                subAlertButtonTextStyle()!,
                alertButtonStyle()!,
              ),
              divider(),
              toggleButton(
                SILENCE_THIS_ALERT_UI,
                "",
                isOn,
                setToggle,
                alertButtonTextStyle()!,
                subAlertButtonTextStyle()!,
                alertButtonStyle()!,
              ),
              divider(),
              alertButton(
                UPDATE_THIS_ALERT_UI,
                RERECORD,
                alertButtonTextStyle()!,
                subAlertButtonTextStyle()!,
                alertButtonStyle()!,
              ),
              divider(),
              alertButton(
                CATEGORY_UI,
                HOME_CATEGORY_UI,
                alertButtonTextStyle()!,
                subAlertButtonTextStyle()!,
                alertButtonStyle()!,
              ),
              divider(),
            ],
          )
        ],
      ),
    );
  }
}
