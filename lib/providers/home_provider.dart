import 'dart:convert';
import 'dart:io';

import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/repositorys/home/i_home_repository.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HomeProvider extends ChangeNotifier {
  final IHomeRepository _homeRepository;
  HomeProvider(this._homeRepository);

  ApiState apisState = ApiState.COMPLETED;
  String? _categoryValue;
  String? _serviceValue;
  String? _nationalityValue = '';
  String? _sexValue = '';
  String? _groupItemValue = 'ALL';
  String _exceptionText = '';

  num _countValue = 1;

  String get getCategoryValue => _categoryValue!;
  String get getServiceValue => _serviceValue!;
  String get getNationalityValue => _nationalityValue!;
  String get getSexValue => _sexValue!;
  String get getGroupItemValue => _groupItemValue!;
  String get getExceptionText => _exceptionText;
  num get getCountValue => _countValue;
  List<String> get getServiceItem => _serviceItems;
  List<String> get getCategoryItem => _categoryItems;
  List<String> get getNationalityItem => _nationalityItem;
  List<String> get getSexItem => _sexItem;
  List<String> get getGroupItem => _groupItem;

  bool loading = false;
  CoreInitModel? coreInitModel;
  SaleModeData? saleModeData;
  List<SaleModeData>? saleModeDataList;

  init() async {
    saleModeDataList = [];
    checkReadCoreData();
  }

  checkReadCoreData() async {
    bool statusCoreData = await SharedPref().getNewDataSwitch();
    if (statusCoreData) {
      getCoreDataInit();
    } else {
      String? fileResponse = await _readCoreInit(Constants.SALE_MODE_TXT);
      if (fileResponse == '') {
        getCoreDataInit();
      } else {
        saleModeDataList = (jsonDecode(fileResponse) as List)
            .map((e) => SaleModeData.fromJson(e))
            .toList();
        Constants().printWarning('Read from file "${Constants.SALE_MODE_TXT}"');
      }
    }
    notifyListeners();
  }

  Future getCoreDataInit() async {
    apisState = ApiState.LOADING;
    var response = await _homeRepository.getCoreDataDetail(
      deviceKey: '0288-7363-6560-2714',
      langID: '1',
    );
    if (response is Failure) {
      apisState = ApiState.ERROR;
      Constants().printError(response.code.toString());
      Constants().printError(response.errorResponse.toString());
    } else {
      try {
        coreInitModel = CoreInitModel.fromJson(jsonDecode(response));
        await Future.wait(
          [
            _writeCoreInit(jsonEncode(coreInitModel!.responseObj!.saleModeData),
                Constants.SALE_MODE_TXT),
            _writeCoreInit(
                jsonEncode(
                    coreInitModel!.responseObj!.productData!.productGroup),
                Constants.PROD_GROUP_TXT),
            _writeCoreInit(
                jsonEncode(coreInitModel!.responseObj!.productData!.products),
                Constants.PROD_TXT),
            _writeCoreInit(
                jsonEncode(coreInitModel!.responseObj!.favoriteGroup),
                Constants.FAV_GROUP_TXT),
            _writeCoreInit(jsonEncode(coreInitModel!.responseObj!.favoriteData),
                Constants.FAV_DATA_TXT)
          ],
        );
        saleModeDataList = coreInitModel!.responseObj!.saleModeData;

        apisState = ApiState.COMPLETED;
        Constants().printInfo(response.toString());
        Constants().printWarning('CoreDataInit');
      } catch (e, strack) {
        apisState = ApiState.ERROR;
        _exceptionText = e.toString();
        Constants().printError(e.toString());
        Constants().printError(strack.toString());
      }
    }
    notifyListeners();
  }

  Future _writeCoreInit(String text, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$fileName');
    await file.writeAsString(text);
  }

  Future<String> _readCoreInit(String filename) async {
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
    } catch (e) {
      Constants().printError("Couldn't read file '$filename'");
    }
    return text!;
  }

  addCount() {
    _countValue++;
    notifyListeners();
  }

  removeCount() {
    if (_countValue > 1) _countValue--;
    notifyListeners();
  }

  setGroupItemValue(String value) {
    _groupItemValue = value;
    notifyListeners();
  }

  setSex(String value) {
    _sexValue = value;
    notifyListeners();
  }

  setNationality(String value) {
    _nationalityValue = value;
    notifyListeners();
  }

  setCategoryValue(String value) {
    _categoryValue = value;
    notifyListeners();
  }

  setServiceValue(String value) {
    _serviceValue = value;
    notifyListeners();
  }

  final List<String> _serviceItems = ['service1', 'service2'];
  final List<String> _categoryItems = ['category1', 'category2'];
  final List<String> _nationalityItem = ['ชาวไทย', 'ชาวต่างชาติ', 'ต่างด่าว'];
  final List<String> _sexItem = ['หญิง', 'ชาย'];
  final List<String> _groupItem = [
    'ALL',
    'TAKE AWAY',
    'DRIVE THRU',
    'DELIVERY',
    'CREDIT SALES',
    'FAGT DELIVERY',
  ];
}
