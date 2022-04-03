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
      : alertId = json['alertId'] as int,
        alertName = json['alertName'] as String,
        alertCategory = json['alertCategory'] as String,
        alertDuration = json['alertDuration'] as int;

  Map<String, dynamic> toJson() => {
        'alertId': alertId,
        'alertName': alertName,
        'alertCategory': alertCategory,
        'alertDuration': alertDuration
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
