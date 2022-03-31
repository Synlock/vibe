import 'package:flutter/material.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/viewModel/appBarViewModel.dart';

AppBar mainAppBar(String appBarText) {
  return AppBar(
    title: Text(appBarText),
    actions: <Widget>[
      PopupMenuButton<String>(
        onSelected: handleMenuBtnItems,
        itemBuilder: (BuildContext context) {
          return {ADD_NEW_ALERT, SAVED_ALERTS, SETTINGS}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      ),
    ],
  );
}
