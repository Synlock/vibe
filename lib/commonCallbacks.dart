import 'package:flutter/material.dart';

VoidCallback handleNewRoute(BuildContext context, Widget pageToRouteTo) {
  return (() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => pageToRouteTo,
      ),
    );
  });
}
