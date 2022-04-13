import 'package:vibe/misc/tags.dart';

enum dataTagging { match, noMatch, notSure, noAnswer }

class AlertTaggingData {
  int userId;
  List<int> audioClip;
  String clipLabel;
  int response;
  DateTime timeStamp;

  @override
  bool operator ==(Object other) =>
      other is AlertTaggingData &&
      (other.response == response || other.timeStamp == timeStamp);

  @override
  int get hashCode => timeStamp.hashCode;

  AlertTaggingData({
    required this.userId,
    required this.audioClip,
    required this.clipLabel,
    required this.response,
    required this.timeStamp,
  });

  AlertTaggingData.fromJson(Map<String, dynamic> json)
      : userId = json[USER_ID] as int,
        audioClip = json[AUDIO_CLIP] as List<int>,
        clipLabel = json[CLIP_LABEL] as String,
        response = json[RESPONSE_INDEX] as int,
        timeStamp = json[TIME_STAMP] as DateTime;

  Map<String, dynamic> toJson() => {
        USER_ID: userId,
        AUDIO_CLIP: audioClip,
        CLIP_LABEL: clipLabel,
        RESPONSE_INDEX: response,
        TIME_STAMP: timeStamp,
      };
}

class DataTag {
  int index;
  String name;

  DataTag({
    required this.index,
    required this.name,
  });

  DataTag.fromJson(Map<String, dynamic> json)
      : index = json[DATA_TAG_INDEX] as int,
        name = json[DATA_TAG_NAME] as String;

  Map<String, dynamic> toJson() => {
        DATA_TAG_INDEX: index,
        DATA_TAG_NAME: name,
      };
}
