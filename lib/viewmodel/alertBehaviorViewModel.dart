import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:torch_light/torch_light.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/viewmodel/pushNotificationViewModel.dart';
import 'package:vibration/vibration.dart';

Timer soundTimer = Timer.periodic(Duration.zero, (timer) {});
Timer vibrateTimer = Timer.periodic(Duration.zero, (timer) {});
Timer flashTimer = Timer.periodic(Duration.zero, (timer) {});

Future<void> alertBehaviorHandler(
  AlertBehavior alertBehavior,
  AudioPlayer? audioPlayer,
  int pauseBetweenInSecs,
  bool isActive,
) async {
  if (alertBehavior.isSound) {
    soundTimer = Timer.periodic(Duration(seconds: pauseBetweenInSecs), (timer) {
      if (!isActive) timer.cancel();

      playSoundUntilCancelled(audioPlayer!);
    });
  }
  if (alertBehavior.isVibrate) {
    vibrateTimer =
        Timer.periodic(Duration(seconds: pauseBetweenInSecs), (timer) {
      if (!isActive) timer.cancel();
      print("vibrate");
      vibrateUntilCancelled();
    });
  }
  if (alertBehavior.isFlash) {
    flashTimer = Timer.periodic(Duration(seconds: pauseBetweenInSecs), (timer) {
      if (!isActive) timer.cancel();
      print("flash");

      flashUntilCancelled();
    });
  }
  createCancelAlertNotification("Alert Name");
}

void turnOffAllTimers() {
  soundTimer.cancel();
  vibrateTimer.cancel();
  flashTimer.cancel();
}

void playSoundUntilCancelled(AudioPlayer audioPlayer) async {
  await Future.delayed(const Duration(seconds: 2), () async {
    await audioPlayer.setAsset("assets/sound/test.wav");
    await audioPlayer.play();
  });
}

int count = 0;
void vibrateUntilCancelled() async {
  if (await Vibration.hasCustomVibrationsSupport()) {
    await Future.delayed(const Duration(milliseconds: 2000), () async {
      await Vibration.vibrate(duration: 1000);
    });
  } else {
    await Future.delayed(const Duration(milliseconds: 500), () async {
      await Vibration.vibrate();
    });
  }
}

void flashUntilCancelled() async {
  try {
    final isTorchAvailable = await TorchLight.isTorchAvailable();
    if (isTorchAvailable) {
      await Future.delayed(const Duration(seconds: 2), () async {
        await TorchLight.enableTorch();
      });
      await Future.delayed(const Duration(seconds: 2), () async {
        await TorchLight.disableTorch();
      });
    }
  } on Exception catch (_) {
    // Handle error
  }
}
