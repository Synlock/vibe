import 'package:flutter/material.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/view/appBar.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(SETTINGS),
    );
  }
}
