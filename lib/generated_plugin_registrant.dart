//
// Generated file. Do not edit.
//

// ignore_for_file: directives_ordering
// ignore_for_file: lines_longer_than_80_chars

import 'package:audio_session/audio_session_web.dart';
import 'package:just_audio_web/just_audio_web.dart';
import 'package:record_web/record_web.dart';
import 'package:vibration_web/vibration_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  AudioSessionWeb.registerWith(registrar);
  JustAudioPlugin.registerWith(registrar);
  RecordPluginWeb.registerWith(registrar);
  VibrationWebPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
