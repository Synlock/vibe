import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sound_stream/sound_stream.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/model/soundListModel.dart';
import 'package:vibe/view/alertBannerView.dart';
import 'package:vibe/view/dataTaggingPopupView.dart';

//SoundStreamer soundStreamer = SoundStreamer();

class SoundStreamController {
  final RecorderStream recorder = RecorderStream();

  List<Uint8List> micChunks = [];
  List<Uint8List> fourSecChunks = [];
  bool isRecording = false;

  StreamSubscription? recorderStatus;
  StreamSubscription? audioStream;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    recorderStatus = recorder.status.listen((status) {
      isRecording = status == SoundStreamStatus.Playing;
    });

    audioStream = recorder.audioStream.listen((data) {
      micChunks.add(data);
      print(micChunks);
      //14 ticks per second
      if (micChunks.length >= 224) {
        micChunks.removeAt(0);
      }
      if (micChunks.length >= 60) {
        fourSecChunks = micChunks
            .getRange(
              micChunks.indexOf(micChunks.last) - 56,
              micChunks.indexOf(micChunks.last),
            )
            .toList();
      }
    });

    await Future.wait([
      recorder.initialize(),
    ]);
  }
}

class SoundStreamer {
  SoundStreamController stream = SoundStreamController();
  List<List<List<int>>> cachedSamples = [];

  void initSoundStream() async {
    if (stream.isRecording) return;

    await stream.initPlugin();

    final json = await getDecodedJson(SETTINGS_JSON_FILE_NAME);
    if (json[IS_SILENT]) return;

    streamRecorderController();
  }

  void streamRecorderController() async {
    await stream.recorder.start();

    Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        if (!stream.isRecording) timer.cancel();
        //24 * 500 ms equals 12 seconds
        if (cachedSamples.length >= 24) {
          cachedSamples.removeAt(0);
          cachedSamples.add(stream.fourSecChunks);
          return;
        }

        cachedSamples.add(stream.fourSecChunks);
      },
    );
  }

  void stopRecorder() async {
    await stream.recorder.stop();
  }

  void getAlgorithmAnswer(BuildContext context, AlertData alertData,
      String answer, List<List<int>> audioClip) {
    if (answer == "0") {
      cachedSamples.remove(audioClip);
      return;
    }
    try {
      for (var item in PredefinedAlertTags.predefinedAlertTags) {
        if (answer == item) {
          alertData.alertBehavior.isFullPage
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AlertBanner(
                            alert: AlertData(
                              alertId: alertData.alertId,
                              alertName: alertData.alertName,
                              alertCategory: alertData.alertCategory,
                              alertIcon: alertData.alertIcon,
                              alertDuration: 0,
                              alertPath: alertData.alertPath,
                              alertBehavior: alertData.alertBehavior,
                            ),
                          )),
                )
              : showAlertBox(context, alertData);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}

void showAlertBox(BuildContext context, AlertData alertData) async {
  var navigationResult = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertPopup(
          alert: AlertData(
            alertId: alertData.alertId,
            alertName: alertData.alertName,
            alertCategory: alertData.alertCategory,
            alertIcon: alertData.alertIcon,
            alertDuration: 0,
            alertPath: alertData.alertPath,
            alertBehavior: alertData.alertBehavior,
          ),
        );
      });
}

void showDataTaggingBox(
    BuildContext context, String alertName, IconData alertIcon) async {
  var navigationResult = await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return DataTaggingPopup(
        alertIcon: alertIcon,
        alertName: alertName,
      );
    },
  );
}
