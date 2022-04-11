import 'package:vibe/misc/tags.dart';

class AlertData {
  int alertId;
  String alertName;
  String alertCategory;
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
        alertCategory = json[ALERT_CATEGORY] as String,
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

List<AlertData> alerts = [];
List<CategoryData> categories = [];
