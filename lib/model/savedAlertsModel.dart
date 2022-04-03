class AlertData {
  final int alertId;
  final String alertName;
  final CategoryData categoryData;
  final String alertDuration;

  AlertData(
      this.alertId, this.alertName, this.categoryData, this.alertDuration);
}

class CategoryData {
  final int categoryId;
  final String categoryName;

  CategoryData(this.categoryId, this.categoryName);
}

List<AlertData>? alerts = [];
List<CategoryData>? categories = [];
