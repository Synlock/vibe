import 'package:flutter/material.dart';

Color indigoColor = const Color.fromARGB(255, 74, 94, 163);
Color yellowColor = const Color.fromARGB(255, 255, 177, 92);
double iconSize = 75.0;

ButtonStyle? homepageButtonStyle() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all<double>(10.0),
    backgroundColor: MaterialStateProperty.all<Color>(indigoColor),
    shadowColor: MaterialStateProperty.all<Color>(Colors.black),
    minimumSize: MaterialStateProperty.all<Size>(const Size(350.0, 30.0)),
  );
}

TextStyle? homepageButtonTextStyle() {
  return TextStyle(
    color: yellowColor,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    height: 7.0,
  );
}

//Main Button
ButtonStyle? mainButtonStyle() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
    minimumSize: MaterialStateProperty.all<Size>(const Size(125.0, 30.0)),
  );
}

TextStyle? mainButtonTextStyle() {
  return const TextStyle(
    color: Colors.white,
  );
}
