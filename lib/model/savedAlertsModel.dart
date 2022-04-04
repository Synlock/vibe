import 'package:vibe/tags.dart';

class AlertData {
  final int alertId;
  final String alertName;
  final String alertCategory;
  final int alertDuration;

  AlertData(
      {required this.alertId,
      required this.alertName,
      required this.alertCategory,
      required this.alertDuration});

  AlertData.fromJson(Map<String, dynamic> json)
      : alertId = json[ALERT_ID] as int,
        alertName = json[ALERT_NAME] as String,
        alertCategory = json[ALERT_CATEGORY] as String,
        alertDuration = json[ALERT_DURATION] as int;

  Map<String, dynamic> toJson() => {
        ALERT_ID: alertId,
        ALERT_NAME: alertName,
        ALERT_CATEGORY: alertCategory,
        ALERT_DURATION: alertDuration
      };
}

class CategoryData {
  final int categoryId;
  final String categoryName;

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
