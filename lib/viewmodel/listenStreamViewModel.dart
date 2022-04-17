import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/model/soundListModel.dart';
import 'package:vibe/view/alertBannerView.dart';
import 'package:vibe/viewmodel/micStreamViewModel.dart';

SoundStreamController stream = SoundStreamController();

Timer timer = Timer(Duration.zero, () {});

List<List<List<int>>> cachedSamples = [];

void initSoundStream() async {
  await stream.initPlugin();
  await stream.recorder.start();

  stream1RecorderController();
}

void stream1RecorderController() async {
  await stream.recorder.start();
  timer = Timer.periodic(
    const Duration(milliseconds: 500),
    (timer) {
      if (!stream.isRecording) timer.cancel();
      cachedSamples.add(stream.fourSecChunks);
    },
  );
}

void stopRecorders() async {
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
