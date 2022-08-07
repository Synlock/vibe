//TODO: send last index of cachedSamples to algo
//TODO: algo sends back answer
//TODO: receive "0" means the algorithm found no match
//TODO: clear entry from list
//TODO: recieve back name of alert if there is a match
//TODO: show alert banner/popup with alert info
//TODO: after one minute ask user if the detection was correct
//TODO: send back data to db when internet is active
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vibe/styles/appBar.dart';
import 'package:vibe/styles/styles.dart';

class PythonDemo extends StatefulWidget {
  const PythonDemo({Key? key}) : super(key: key);

  @override
  State<PythonDemo> createState() => _PythonDemoState();
}

class _PythonDemoState extends State<PythonDemo> {
  Future<String> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      print("Cannot get download folder path");
    }
    return directory!.path;
  }

  var urlType = 'https://genial-smoke-358610.oa.r.appspot.com/type';
  var urlJsonCheck = 'https://genial-smoke-358610.oa.r.appspot.com/json-check';
  var urlReturnJsonObject =
      'https://genial-smoke-358610.oa.r.appspot.com/return-json-object';
  Future<String> getServerResponse() async {
    Directory directory = Directory(await getDownloadPath());
    String audioFilePath = directory.path + "/dogBarkSound.wav";
    dynamic stringedAudio = await File(audioFilePath).readAsBytes();

    print(stringedAudio);
    //var req = await http.post(Uri.parse(audioFilePath));
    var stringData = "";
    try {
      var req = await HttpClient().postUrl(Uri.parse(urlJsonCheck));
      req.write(stringedAudio);
      var res = await req.close();

      stringData = await res.transform(utf8.decoder).join();
    } catch (e) {
      print(e.toString());
    }
    return stringData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, "Vibe"),
      backgroundColor: indigoColor,
      body: const Text(""),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String a = await getServerResponse();
          print(a);
          //send to python server on press here
        },
        child: const Text(""),
      ),
    );
  }
}
