import 'package:flutter/material.dart';

AppBar mainAppBar(BuildContext context, String appBarText) {
  return AppBar(
    automaticallyImplyLeading: false,
    actions: <Widget>[
      // PopupMenuButton<String>(
      //   onSelected: handleMenuBtnItems,
      //   itemBuilder: (BuildContext context) {
      //     return {ADD_NEW_ALERT, SAVED_ALERTS, SETTINGS}.map((String choice) {
      //       return PopupMenuItem<String>(
      //         value: choice,
      //         child: Text(choice),
      //       );
      // }).toList();
      // },
      // ),
      Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Center(
          child: Text(
            appBarText,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_forward),
      ),
    ],
  );
}
