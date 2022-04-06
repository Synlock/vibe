import 'package:flutter/material.dart';
import 'package:vibe/commonCalls.dart';
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

//TODO: add on pressed to these buttons
ElevatedButton alertButton(
  String mainText,
  String subText,
  TextStyle mainTextStyle,
  TextStyle subTextStyle,
  ButtonStyle buttonStyle,
) =>
    ElevatedButton(
      onPressed: () {},
      child: Column(
        children: [
          SizedBox(
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
        ],
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
  String buttonText,
) =>
    ElevatedButton(
      onPressed: () {},
      child: Text(
        buttonText,
        style: saveCloudTextStyle(),
      ),
      style: roundedButtonStyle(),
    );

Divider divider() => const Divider(
      height: 1,
      thickness: 0.5,
      indent: 20,
      endIndent: 20,
      color: Colors.black26,
    );
