import 'dart:async';

import 'package:vibe/viewmodel/micStreamViewModel.dart';

SoundStream stream1 = SoundStream();
SoundStream stream2 = SoundStream();

Timer timer1 = Timer(Duration.zero, () {});
Timer timer2 = Timer(Duration.zero, () {});

List<List<List<int>>> cachedSamples = [];

void initSoundStream() async {
  await stream1.initPlugin();
  await stream1.recorder.start();
  await stream2.initPlugin();
  await stream2.recorder.start();

  streamRecorderController(true);
}

//TODO: implement my own timer
void streamRecorderController(bool isOn) async {
  timer1 = Timer.periodic(const Duration(seconds: 4), (timer) async {
    if (!isOn) {
      timer1.cancel();
      await stream1.recorder.stop();
    }
    await stream1.recorder.start();
    cachedSamples.add(stream1.micChunks);
    print("added");
  });
  timer2 = Timer.periodic(const Duration(seconds: 3), (timer) async {
    if (!isOn) {
      timer2.cancel();
      await stream2.recorder.stop();
    }
    await stream2.recorder.start();
    cachedSamples.add(stream2.micChunks);
    print("added");
  });
}
