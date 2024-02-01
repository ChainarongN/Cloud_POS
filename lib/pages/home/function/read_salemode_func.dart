import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ReadSaleModeFunc {
  ReadSaleModeFunc._internal();
  static final ReadSaleModeFunc _instance = ReadSaleModeFunc._internal();
  factory ReadSaleModeFunc() => _instance;

  Future<String> readCoreInit(String filename) async {
    String? text;
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$filename');
    bool fileExists = file.existsSync();
    if (fileExists) {
      text = await file.readAsString();
    } else {
      text = '';
    }
    return text;
  }
}
