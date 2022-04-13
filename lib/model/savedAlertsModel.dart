import 'package:vibe/misc/tags.dart';

class AlertData {
  int alertId;
  String alertName;
  String alertCategory;
  int alertIcon;
  int alertDuration;
  String alertPath;
  AlertBehavior alertBehavior;

  @override
  bool operator ==(Object other) =>
      other is AlertData && other.alertIcon == alertIcon;

  @override
  int get hashCode => alertIcon.hashCode;

  AlertData({
    required this.alertId,
    required this.alertName,
    required this.alertCategory,
    required this.alertIcon,
    required this.alertDuration,
    required this.alertPath,
    required this.alertBehavior,
  });

  AlertData.fromJson(Map<String, dynamic> json)
      : alertId = json[ALERT_ID] as int,
        alertName = json[ALERT_NAME] as String,
        alertCategory = json[ALERT_CATEGORY] as String,
        alertIcon = json[ALERT_ICON] as int,
        alertDuration = json[ALERT_DURATION] as int,
        alertPath = json[ALERT_PATH] as String,
        alertBehavior = json[ALERT_BEHAVIOR] as AlertBehavior;

  Map<String, dynamic> toJson() => {
        ALERT_ID: alertId,
        ALERT_NAME: alertName,
        ALERT_CATEGORY: alertCategory,
        ALERT_ICON: alertIcon,
        ALERT_DURATION: alertDuration,
        ALERT_PATH: alertPath,
        ALERT_BEHAVIOR: alertBehavior,
      };
}

class CategoryData {
  String categoryName;
  int categoryIcon;

  @override
  bool operator ==(Object other) =>
      other is CategoryData &&
      (other.categoryName == categoryName ||
          other.categoryIcon == categoryIcon);

  @override
  int get hashCode => categoryIcon.hashCode;

  CategoryData({
    required this.categoryName,
    required this.categoryIcon,
  });

  CategoryData.fromJson(Map<String, dynamic> json)
      : categoryName = json[CATEGORY_NAME] as String,
        categoryIcon = json[CATEGORY_ICON] as int;

  Map<String, dynamic> toJson() => {
        CATEGORY_NAME: categoryName,
        CATEGORY_ICON: categoryIcon,
      };
}

class AlertBehavior {
  bool isFullPage;
  bool isSound;
  bool isVibrate;
  bool isFlash;
  bool isSilent;

  AlertBehavior({
    required this.isFullPage,
    required this.isSound,
    required this.isVibrate,
    required this.isFlash,
    required this.isSilent,
  });

  AlertBehavior.fromJson(Map<String, dynamic> json)
      : isFullPage = json[IS_FULL_PAGE] as bool,
        isSound = json[IS_SOUND] as bool,
        isVibrate = json[IS_VIBRATE] as bool,
        isFlash = json[IS_FLASH] as bool,
        isSilent = json[IS_SILENT] as bool;

  Map<String, dynamic> toJson() => {
        IS_FULL_PAGE: isFullPage,
        IS_SOUND: isSound,
        IS_VIBRATE: isVibrate,
        IS_FLASH: isFlash,
        IS_SILENT: isSilent,
      };
}

List<AlertData> alerts = [];
List<CategoryData> categories = [];
List<AlertBehavior> alertBehaviors = [];
