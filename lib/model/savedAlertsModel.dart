import 'package:vibe/tags.dart';

class AlertData {
  int alertId;
  String alertName;
  String alertCategory;
  int alertDuration;
  String alertPath;
  String typeOfAlert;
  bool isSilent;

  AlertData({
    required this.alertId,
    required this.alertName,
    required this.alertCategory,
    required this.alertDuration,
    required this.alertPath,
    required this.typeOfAlert,
    required this.isSilent,
  });

  AlertData.fromJson(Map<String, dynamic> json)
      : alertId = json[ALERT_ID] as int,
        alertName = json[ALERT_NAME] as String,
        alertCategory = json[ALERT_CATEGORY] as String,
        alertDuration = json[ALERT_DURATION] as int,
        alertPath = json[ALERT_PATH] as String,
        typeOfAlert = json[TYPE_OF_ALERT] as String,
        isSilent = json[IS_SILENT] as bool;

  Map<String, dynamic> toJson() => {
        ALERT_ID: alertId,
        ALERT_NAME: alertName,
        ALERT_CATEGORY: alertCategory,
        ALERT_DURATION: alertDuration,
        ALERT_PATH: alertPath,
        TYPE_OF_ALERT: typeOfAlert,
        IS_SILENT: isSilent,
      };
}

class CategoryData {
  int categoryId;
  String categoryName;

  CategoryData({
    required this.categoryId,
    required this.categoryName,
  });

  CategoryData.fromJson(Map<String, dynamic> json)
      : categoryId = json['categoryId'] as int,
        categoryName = json['categoryName'] as String;

  Map<String, dynamic> toJson() => {
        'categoryId': categoryId,
        'categoryName': categoryName,
      };
}

List<AlertData> alerts = [];
List<CategoryData> categories = [];
