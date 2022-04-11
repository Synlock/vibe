import 'package:flutter/material.dart';
import 'package:vibe/misc/tags.dart';

AppBar mainAppBar(BuildContext context, String appBarText) {
  return AppBar(
    automaticallyImplyLeading: false,
    actions: <Widget>[
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
      ModalRoute.of(context)!.settings.name != HOME_ROUTE
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_forward),
            )
          : Container(),
    ],
  );
}

AppBar savedAlertsAppBar(
    BuildContext context, String appBarText, PreferredSizeWidget? bottom) {
  return AppBar(
    automaticallyImplyLeading: false,
    actions: <Widget>[
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
      ModalRoute.of(context)!.settings.name != HOME_ROUTE
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_forward),
            )
          : Container(),
    ],
    bottom: bottom,
  );
}
