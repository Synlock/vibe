//TODO: send last index of cachedSamples to algo
//TODO: algo sends back answer
//TODO: receive "0" means the algorithm found no match
//TODO: clear entry from list
//TODO: recieve back name of alert if there is a match
//TODO: show alert banner/popup with alert info
//TODO: after one minute ask user if the detection was correct
//TODO: send back data to db when internet is active

import 'package:flutter/material.dart';
import 'package:vibe/styles/appBar.dart';
import 'package:vibe/styles/styles.dart';

class PythonCommunicator extends StatefulWidget {
  const PythonCommunicator({Key? key}) : super(key: key);

  @override
  State<PythonCommunicator> createState() => _PythonCommunicatorState();
}

//Future<dynamic> python() async {
//  final _result = await Chaquopy.executeCode("""
// import utils
// from logic import naiveClassifier, smartClassifier, final_decision
// import sys
// import json

// config = json.load(open('config.json'))

// naive_classifier = naiveClassifier(config['naive_sampling_rate'])
// smart_classifier = smartClassifier(config['smart_model_path'])

// def classify(audio_file):

//     #  load and pre-processing
//     audio_wave = utils.load_audio_file(audio_file)

//     # apply naive logic
//     naive_classification = naive_classifier.classify(audio_wave)

//     # apply smart logic
//     smart_classification = smart_classifier.classify(audio_wave)

//     # return the final decision
//     return final_decision(naive_classification, smart_classification)

// if __name__ == '__main__':
//     prediction = classify(sys.argv[1])
//     print(prediction)

// """);
//   final result = await Chaquopy.executeCode("""
// import utils
// from logic import naiveClassifier, smartClassifier, final_decision
// import sys
// import json

// config = json.load(open('config.json'))
// naive_classifier = naiveClassifier(config['naive_sampling_rate'])
// smart_classifier = smartClassifier(config['smart_model_path'])
// def classify(audio_file):
//     #  load and pre-processing
//     audio_wave = utils.load_audio_file(audio_file)
//     # apply naive logic
//     naive_classification = naive_classifier.classify(audio_wave)
//     # apply smart logic
//     smart_classification = smart_classifier.classify(audio_wave)
//     # return the final decision
//     return final_decision(naive_classification, smart_classification)
// if __name__ == '__main__':
//     prediction = classify(sys.argv[1])
//     print(prediction)
// """);
//   print(result.values.first);
//   return result;
// }

class _PythonCommunicatorState extends State<PythonCommunicator> {
  dynamic s = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, "Vibe"),
      backgroundColor: indigoColor,
      body: Center(
        child: Column(
          children: [
            Text(
              s.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            TextButton(
              onPressed: () async {
                const j = ""; //await python();
                setState(
                  () {
                    s = j;
                  },
                );
              },
              child: const Text("Run Code"),
            ),
          ],
        ),
      ),
    );
  }
}
