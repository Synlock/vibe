import 'package:flutter/material.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/view/appBar.dart';

class SoundPage extends StatefulWidget {
  const SoundPage({Key? key}) : super(key: key);

  @override
  State<SoundPage> createState() => _SoundPageState();
}

class _SoundPageState extends State<SoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(ALERT),
      body: Container(),
    );
  }
}
