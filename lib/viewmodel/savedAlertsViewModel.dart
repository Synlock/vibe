import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vibe/commonCalls.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/tags.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';

List<AlertData>? getAlerts() => alerts;
List<CategoryData>? getCategories() => categories;

Future<void> initAlertsList() async {
  final json = await decodedAlertsJson();
  print(json);

  Directory directory = Directory(getPathToRecordings());
  for (var i = 0; i < directory.listSync().length; i++) {
    if (alerts.length >= directory.listSync().length) break;

    final item = json[i];
    alerts.add(
      AlertData(
        alertId: item["alertId"],
        alertName: item["alertName"],
        alertCategory: item["alertCategory"],
        alertDuration: item["alertDuration"],
      ),
    );
  }
}

void initCategoryList() {
  categories.add(CategoryData(categoryId: 0, categoryName: "Default"));
  categories.add(CategoryData(categoryId: 1, categoryName: "Appliances"));
  categories.add(CategoryData(categoryId: 2, categoryName: "House Entrances"));
}

void populateCategoryList(CategoryData? newData) {
  categories.add(newData!);
}
