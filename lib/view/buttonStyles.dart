import 'package:flutter/material.dart';

//Main Text Button
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
