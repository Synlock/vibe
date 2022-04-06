import 'package:flutter/material.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/styles/styles.dart';

Padding homepageButton(
  BuildContext context,
  Widget pageToRouteTo,
  String buttonText,
  IconData icon,
) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
      child: ElevatedButton(
        onPressed: handleNewRoute(context, pageToRouteTo),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: yellowColor,
            ),
            Text(
              buttonText,
              style: homepageButtonTextStyle(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        style: homepageButtonStyle(),
      ),
    );

ElevatedButton alertButton(
  VoidCallback onPressed,
  String mainText,
  String subText,
  TextStyle mainTextStyle,
  TextStyle subTextStyle,
  ButtonStyle buttonStyle,
) =>
    ElevatedButton(
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              mainText,
              style: mainTextStyle,
              textAlign: TextAlign.right,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                subText,
                style: subTextStyle,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
      style: buttonStyle,
    );

ElevatedButton toggleButton(
  String buttonText,
  String buttonSubText,
  bool value,
  Function(bool)? onChanged,
  TextStyle textStyle,
  TextStyle subTextStyle,
  ButtonStyle buttonStyle,
) =>
    ElevatedButton(
      onPressed: () {}, //<add toggle function here
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Transform.scale(
            scale: 1.1,
            child: Transform.scale(
              scaleX: -1,
              child: Switch.adaptive(
                value: value, //<< if true toggle is switched on
                onChanged: onChanged, //< Callback for toggle
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                buttonText,
                style: textStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  buttonSubText,
                  style: subTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
      style: buttonStyle,
    );

ElevatedButton roundedButton(
  VoidCallback onPressed,
  String buttonText,
) =>
    ElevatedButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: saveCloudTextStyle(),
      ),
      style: roundedButtonStyle(),
    );

ElevatedButton miniRoundedButton(
  VoidCallback onPressed,
  String buttonText,
) =>
    ElevatedButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: mainButtonTextStyle(),
      ),
      style: miniRoundedButtonStyle(),
    );

ElevatedButton iconTextStackButton(
        VoidCallback onPressed, String alertName, IconData icon) =>
    ElevatedButton(
      onPressed: onPressed,
      child: Column(
        children: [
          Icon(
            icon,
            size: 100,
            color: yellowColor,
          ),
          Text(
            alertName,
            style: homepageButtonTextStyle(),
          ),
        ],
      ),
      style: iconTextButtonStyle(),
    );

Divider divider() => const Divider(
      height: 3,
      thickness: 1,
      indent: 20,
      endIndent: 20,
      color: Colors.black12,
    );
