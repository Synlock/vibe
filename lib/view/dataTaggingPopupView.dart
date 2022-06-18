import 'package:flutter/material.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/model/dataTaggingModel.dart';
import 'package:vibe/styles/buttons.dart';

class DataTaggingPopup extends StatefulWidget {
  final IconData alertIcon;
  final String alertName;
  const DataTaggingPopup({
    Key? key,
    required this.alertIcon,
    required this.alertName,
  }) : super(key: key);

  @override
  State<DataTaggingPopup> createState() => _DataTaggingPopupState();
}

class _DataTaggingPopupState extends State<DataTaggingPopup> {
  @override
  void initState() {
    super.initState();

    // Timer(const Duration(minutes: 10), () {
    //   Mongo.addOneToCollection(AlertTaggingData(
    //     userId: 0,
    //     audioClip: <List<int>>[],
    //     clipLabel: widget.alertName,
    //     response: dataTagging.noAnswer.index,
    //     timeStamp: DateTime.now(),
    //   ).toJson());
    //   Navigator.pop(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(CORRECT_DETECTION),
      actionsPadding: const EdgeInsets.only(bottom: 20.0),
      actions: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: [
                    Icon(
                      widget.alertIcon,
                      size: 50,
                    ),
                    Text(
                      widget.alertName,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
              roundedButton(() {
                // Mongo.addOneToCollection(AlertTaggingData(
                //     userId: 0,
                //     audioClip: <int>[],
                //     tag: dataTagging.match,
                //     timeStamp: DateTime.now()));
                Navigator.pop(context);
              }, "Yes"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: roundedButton(() {
                  // Mongo.addOneToCollection(AlertTaggingData(
                  //     userId: 0,
                  //     audioClip: <int>[],
                  //     tag: dataTagging.noMatch,
                  //     timeStamp: DateTime.now()));
                  Navigator.pop(context);
                }, "No"),
              ),
              roundedButton(() {
                //Mongo.addOneToCollection(convertToJson());

                Navigator.pop(context);
              }, "Not Sure"),
            ],
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> convertToJson() {
    var i = AlertTaggingData(
      userId: 0,
      audioClip: <List<int>>[],
      clipLabel: "",
      response: dataTagging.notSure.index,
      timeStamp: DateTime.now(),
    ).toJson();
    return i;
  }
}
