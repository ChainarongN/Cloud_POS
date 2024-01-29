import 'dart:convert';

import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/repositorys/home/i_home_repository.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:flutter/material.dart';

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
  List<String> get getDetailGroupItem => _detailGroupItem;

  bool loading = false;
  CoreInitModel? coreInitModel;

  init() async {
    getCoreDataInit();
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
        apisState = ApiState.COMPLETED;
        Constants().printInfo(response.toString());
        Constants().printWarning(
            coreInitModel!.responseObj!.saleModeData![0].toString());
      } catch (e, strack) {
        apisState = ApiState.ERROR;
        _exceptionText = e.toString();
        Constants().printError(e.toString());
        Constants().printError(strack.toString());
      }
    }

    notifyListeners();
  }

  writeCoreDataInit() {}

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
  final List<String> _detailGroupItem = [
    'TA_TAKEAWAY_INSTORE',
    'FA_FOOD PANDA',
    'CS_CATERING',
    'TA_TAKEAWAY KIOSK',
    'FA-IN_GRAB FOOD',
    'FA-IN_ROBINHOOD',
    'FA-IN_SHOPEE FOOD',
    'FA-IN-LINE MAN'
  ];
}
