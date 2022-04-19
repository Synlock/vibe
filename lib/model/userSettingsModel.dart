import 'package:vibe/misc/tags.dart';

class UserSettings {
  bool isSilent;
  bool isSilentFrom;
  int timeToSilenceHour;
  int timeToSilenceMinute;
  bool isDoNotDisturb;
  bool isSync;

  UserSettings({
    required this.isSilent,
    required this.isSilentFrom,
    required this.timeToSilenceHour,
    required this.timeToSilenceMinute,
    required this.isDoNotDisturb,
    required this.isSync,
  });

  UserSettings.fromJson(Map<String, dynamic> json)
      : isSilent = json[IS_SILENT] as bool,
        isSilentFrom = json[IS_SILENT_FROM] as bool,
        timeToSilenceHour = json[TIME_TO_SILENCE_HOUR] as int,
        timeToSilenceMinute = json[TIME_TO_SILENCE_MINUTE] as int,
        isDoNotDisturb = json[IS_DO_NOT_DISTURB] as bool,
        isSync = json[IS_SYNC] as bool;

  Map<String, dynamic> toJson() => {
        IS_SILENT: isSilent,
        IS_SILENT_FROM: isSilentFrom,
        TIME_TO_SILENCE_HOUR: timeToSilenceHour,
        TIME_TO_SILENCE_MINUTE: timeToSilenceMinute,
        IS_DO_NOT_DISTURB: isDoNotDisturb,
        IS_SYNC: isSync,
      };
}
