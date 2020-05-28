import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class SaveNetFileLocally {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> localFile(String fileName) async {
    final path = await _localPath;
    return '$path/$fileName';
  }


  Future<Map<String, dynamic>> saveFileFromNetwork(String url, String fileName,
      {Map<String, String> header, bool override = true}) async {
    Dio dio = Dio();
    File file = File(await localFile(fileName));
    if (!override) {
      if (file.existsSync()) {
        return {"status": 2, "path": file.path}; // file exist
      }
    }
    try {
      dio.options.headers = header;
      await dio.download(url, file.path);
      return {"status": 0, "path": file.path}; // file save
    } catch (e) {
      print(e);
      return {"status": 1}; // error
    }
  }

  Future<Map> getFileLocally(String fileName) async {
    try {
      File file = File(await localFile(fileName));
      Uint8List bytesList = file.readAsBytesSync();
      return {"status": 0, "file": bytesList};
    } catch (e) {
      // if error return 0
      return {"status": 1};
    }
  }
}
