import 'package:flutter/material.dart';

Color indigoColor = const Color.fromARGB(255, 74, 94, 163);
Color yellowColor = const Color.fromARGB(255, 255, 177, 92);
double iconSize = 75.0;

ButtonStyle? homepageButtonStyle() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all<double>(10.0),
    backgroundColor: MaterialStateProperty.all<Color>(indigoColor),
    shadowColor: MaterialStateProperty.all<Color>(Colors.black),
    minimumSize: MaterialStateProperty.all<Size>(const Size(50.0, 170.0)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        //side: const BorderSide(color: Colors.grey),
      ),
    ),
  );
}

ButtonStyle? mainButtonStyle() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all<double>(10.0),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
    minimumSize: MaterialStateProperty.all<Size>(const Size(125.0, 80.0)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        //side: const BorderSide(color: Colors.grey),
      ),
    ),
  );
}

ButtonStyle? alertButtonStyle() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all<double>(0.0),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
    minimumSize: MaterialStateProperty.all<Size>(
      const Size(125.0, 80.0),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        //side: const BorderSide(color: Colors.grey),
      ),
    ),
  );
}

ButtonStyle? settingsButtonStyle() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all<double>(0.0),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
    minimumSize: MaterialStateProperty.all<Size>(
      const Size(125.0, 65.0),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        //side: const BorderSide(color: Colors.grey),
      ),
    ),
  );
}

ButtonStyle? roundedButtonStyle() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all<double>(0.0),
    backgroundColor: MaterialStateProperty.all<Color>(yellowColor),
    minimumSize: MaterialStateProperty.all<Size>(
      const Size(230.0, 45.0),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        //side: const BorderSide(color: Colors.grey),
      ),
    ),
  );
}

ButtonStyle? miniRoundedButtonStyle() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all<double>(0.0),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        side: BorderSide(color: indigoColor, width: 2.0),
      ),
    ),
  );
}

ButtonStyle? iconTextButtonStyle() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all<double>(0.0),
    backgroundColor: MaterialStateProperty.all<Color>(indigoColor),
    minimumSize: MaterialStateProperty.all<Size>(
      const Size(230.0, 45.0),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        //side: const BorderSide(color: Colors.grey),
      ),
    ),
  );
}

ButtonStyle? popupButtonStyle() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all<double>(0.0),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
    minimumSize: MaterialStateProperty.all<Size>(
      const Size(0.0, 0.0),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        //side: const BorderSide(color: Colors.grey),
      ),
    ),
  );
}

TextStyle? homepageButtonTextStyle() {
  return TextStyle(
    color: yellowColor,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );
}

TextStyle? mainButtonTextStyle() {
  return TextStyle(
    color: indigoColor,
    fontSize: 20.0,
  );
}

TextStyle? alertButtonTextStyle() {
  return const TextStyle(
    color: Colors.black,
    fontSize: 20.0,
  );
}

TextStyle? subAlertButtonTextStyle() {
  return const TextStyle(
    color: Colors.grey,
    fontSize: 15.0,
  );
}

TextStyle? alertDropdownTextStyle() {
  return const TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
  );
}

TextStyle? saveCloudTextStyle() {
  return const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );
}

TextStyle? popupTextStyle() {
  return TextStyle(
    color: yellowColor,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );
}
