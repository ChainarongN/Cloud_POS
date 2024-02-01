import 'dart:convert';
import 'dart:io';

import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:path_provider/path_provider.dart';

class ReadFileFunc {
  ReadFileFunc._internal();
  static final ReadFileFunc _instance = ReadFileFunc._internal();
  factory ReadFileFunc() => _instance;

  Future<List<ProductGroup>> readProdGroup() async {
    List<ProductGroup> prodGroupList = [];
    String? fileResponse = await _readFile(Constants.PROD_GROUP_TXT);

    prodGroupList = (jsonDecode(fileResponse) as List)
        .map((e) => ProductGroup.fromJson(e))
        .toList();
    Constants().printWarning('Read from file "${Constants.PROD_GROUP_TXT}"');

    return prodGroupList;
  }

  Future<List<Products>> readProd() async {
    List<Products> prodList = [];

    String? fileResponse = await _readFile(Constants.PROD_TXT);
    prodList = (jsonDecode(fileResponse) as List)
        .map((e) => Products.fromJson(e))
        .toList();
    Constants().printWarning('Read from file "${Constants.PROD_TXT}"');

    return prodList;
  }

  Future<String> _readFile(String filename) async {
    String? text;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/$filename');
      bool fileExists = file.existsSync();
      if (fileExists) {
        text = await file.readAsString();
      } else {
        text = '';
      }
    } catch (e, strack) {
      Constants().printError("Couldn't read file '$filename'");
      Constants().printError(e.toString());
      Constants().printError(strack.toString());
    }
    return text!;
  }
}
