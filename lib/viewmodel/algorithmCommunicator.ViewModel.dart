//TODO: send last index of cachedSamples to algo
//TODO: algo sends back answer
//TODO: receive "0" means the algorithm found no match
//TODO: clear entry from list
//TODO: recieve back name of alert if there is a match
//TODO: show alert banner/popup with alert info
//TODO: after one minute ask user if the detection was correct
//TODO: send back data to db when internet is active

import 'package:flutter/material.dart';

class PythonCommunicator extends StatefulWidget {
  PythonCommunicator({Key? key}) : super(key: key);

  @override
  State<PythonCommunicator> createState() => _PythonCommunicatorState();
}

class _PythonCommunicatorState extends State<PythonCommunicator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );
  }
}
