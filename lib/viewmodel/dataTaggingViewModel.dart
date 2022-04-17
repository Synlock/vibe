import 'package:vibe/model/soundListModel.dart';

class FakePythonScript {
  List<String> cachedData;
  FakePythonScript(this.cachedData);
  bool processData() {
    for (var item in PredefinedAlertTags.predefinedAlertTags) {
      for (var data in cachedData) {
        if (item == data) {
          return true;
        } else {
          cachedData.remove(item);
          return false;
        }
      }
    }
    return false;
  }
}
