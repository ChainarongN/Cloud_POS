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

  Future<List<PayTypeInfo>> readPaymentInfo() async {
    List<PayTypeInfo> payDataList = [];
    String? fileResponse = await _readFile(Constants.PAYMENT_GROUP_TXT);
    payDataList = (jsonDecode(fileResponse) as List)
        .map((e) => PayTypeInfo.fromJson(e))
        .toList();
    Constants().printWarning('Read from file "${Constants.PAYMENT_GROUP_TXT}"');
    return payDataList;
  }

  Future<List<FavoriteGroup>> readFavoriteGroup() async {
    List<FavoriteGroup> favoriteGroup = [];
    String? fileResponse = await _readFile(Constants.FAV_GROUP_TXT);
    favoriteGroup = (jsonDecode(fileResponse) as List)
        .map((e) => FavoriteGroup.fromJson(e))
        .toList();
    Constants().printWarning('Read from file "${Constants.FAV_GROUP_TXT}"');
    return favoriteGroup;
  }

  Future<List<FavoriteData>> readFavoriteData() async {
    List<FavoriteData> favoriteData = [];
    String? fileResponse = await _readFile(Constants.FAV_DATA_TXT);
    favoriteData = (jsonDecode(fileResponse) as List)
        .map((e) => FavoriteData.fromJson(e))
        .toList();
    Constants().printWarning('Read from file "${Constants.FAV_DATA_TXT}"');
    return favoriteData;
  }

  Future<List<CurrencyInfo>> readCurrencyInfo() async {
    List<CurrencyInfo> currencyInfo = [];
    String? fileResponse = await _readFile(Constants.CURRENCY_INFO_TXT);
    currencyInfo = (jsonDecode(fileResponse) as List)
        .map((e) => CurrencyInfo.fromJson(e))
        .toList();
    Constants().printWarning('Read from file "${Constants.CURRENCY_INFO_TXT}"');
    return currencyInfo;
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

  Future<ShopData> readShopData() async {
    ShopData shopData;
    String? fileResponse = await _readFile(Constants.SHOP_DATA_TXT);
    shopData = ShopData.fromJson(jsonDecode(fileResponse));
    Constants().printWarning('Read from file "${Constants.SHOP_DATA_TXT}"');
    return shopData;
  }

  Future<ComputerName> readComputerName() async {
    ComputerName computerName;
    String? fileResponse = await _readFile(Constants.COMPUTER_NAME_TXT);
    computerName = ComputerName.fromJson(jsonDecode(fileResponse));
    Constants().printWarning('Read from file "${Constants.COMPUTER_NAME_TXT}"');
    return computerName;
  }

  Future<List<ReasonGroup>> readReason() async {
    List<ReasonGroup> reasonList = [];
    String? fileResponse = await _readFile(Constants.REASON_GROUP_TXT);
    reasonList = (jsonDecode(fileResponse) as List)
        .map((e) => ReasonGroup.fromJson(e))
        .toList();
    Constants().printWarning('Read from file "${Constants.REASON_GROUP_TXT}"');
    return reasonList;
  }

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
