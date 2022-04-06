import 'package:vibe/misc/tags.dart';

class AlertData {
  int alertId;
  String alertName;
  CategoryData alertCategory;
  int alertIcon;
  int alertDuration;
  String alertPath;
  String typeOfAlert;
  bool isSilent;

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
    required this.typeOfAlert,
    required this.isSilent,
  });

  AlertData.fromJson(Map<String, dynamic> json)
      : alertId = json[ALERT_ID] as int,
        alertName = json[ALERT_NAME] as String,
        alertCategory = json[ALERT_CATEGORY] as CategoryData,
        alertIcon = json[ALERT_ICON] as int,
        alertDuration = json[ALERT_DURATION] as int,
        alertPath = json[ALERT_PATH] as String,
        typeOfAlert = json[TYPE_OF_ALERT] as String,
        isSilent = json[IS_SILENT] as bool;

  Map<String, dynamic> toJson() => {
        ALERT_ID: alertId,
        ALERT_NAME: alertName,
        ALERT_CATEGORY: alertCategory,
        ALERT_ICON: alertIcon,
        ALERT_DURATION: alertDuration,
        ALERT_PATH: alertPath,
        TYPE_OF_ALERT: typeOfAlert,
        IS_SILENT: isSilent,
      };
}

class CategoryData {
  String categoryName;

  @override
  bool operator ==(Object other) =>
      other is CategoryData && other.categoryName == categoryName;

  @override
  int get hashCode => categoryName.hashCode;

  CategoryData({
    required this.categoryName,
  });

  CategoryData.fromJson(Map<String, dynamic> json)
      : categoryName = json[CATEGORY_NAME] as String;

  Map<String, dynamic> toJson() => {
        CATEGORY_NAME: categoryName,
      };
}

List<AlertData> alerts = [];
List<CategoryData> categories = [];
