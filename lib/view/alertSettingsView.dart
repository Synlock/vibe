import 'package:flutter/material.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/styles/buttons.dart';
import 'package:vibe/styles/appBar.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/view/updateAlertPopupView.dart';

class AlertSettings extends StatefulWidget {
  int alertId;
  String alertName;
  IconData alertIcon;
  String typeOfAlert;
  bool isSilenced;
  CategoryData alertCategory;
  AlertSettings({
    Key? key,
    required this.alertId,
    required this.alertName,
    required this.alertIcon,
    required this.typeOfAlert,
    required this.isSilenced,
    required this.alertCategory,
  }) : super(key: key);

  @override
  State<AlertSettings> createState() => _AlertSettingsState();
}

class _AlertSettingsState extends State<AlertSettings> {
  void setToggle(bool value) {
    if (!widget.isSilenced) {
      setState(() {
        widget.isSilenced = true;
        //insert silence alarm here
      });
    } else {
      setState(() {
        widget.isSilenced = false;
        //insert silence off alarm here
      });
    }
  }

  void showAlertDetailsBox() async {
    var navigationResult = await showDialog(
        context: context,
        builder: (context) {
          return UpdateAlertBox(
            alertId: widget.alertId,
            alertName: widget.alertName,
            alertCategory: widget.alertCategory,
            iconData: widget.alertIcon,
          );
        });
    if (navigationResult == null) {
      final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
      final item = json[widget.alertId];
      setState(() {
        widget.alertName = item[ALERT_NAME];
        widget.alertIcon =
            IconData(item[ALERT_ICON], fontFamily: 'MaterialIcons');
        widget.alertCategory.categoryName = item[ALERT_CATEGORY][CATEGORY_NAME];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: mainAppBar(ALERT),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 210,
                            color: indigoColor,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 65.0),
                              child: iconTextStackButton(
                                showAlertDetailsBox,
                                widget.alertName,
                                widget.alertIcon,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  alertButton(
                    () {},
                    TYPE_OF_ALERT_UI,
                    widget.typeOfAlert,
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    alertButtonStyle()!,
                  ),
                  divider(),
                  toggleButton(
                    SILENCE_THIS_ALERT_UI,
                    "",
                    widget.isSilenced,
                    setToggle,
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    alertButtonStyle()!,
                  ),
                  divider(),
                  alertButton(
                    () {},
                    UPDATE_THIS_ALERT_UI,
                    RERECORD,
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    alertButtonStyle()!,
                  ),
                  divider(),
                  alertButton(
                    () {},
                    CATEGORY_UI,
                    widget.alertCategory.categoryName,
                    alertButtonTextStyle()!,
                    subAlertButtonTextStyle()!,
                    alertButtonStyle()!,
                  ),
                  divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: FractionallySizedBox(
                      widthFactor: 0.35,
                      child: miniRoundedButton(
                        () {},
                        DELETE,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
