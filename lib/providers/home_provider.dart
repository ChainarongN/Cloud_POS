import 'dart:convert';
import 'package:cloud_pos/service/function/read_file_func.dart';
import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/models/open_tran_model.dart';
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
  String? _errorText = '';

  final TextEditingController _customerCount = TextEditingController();
  num _countValue = 1;

  String get getErrorText => _errorText!;
  TextEditingController get getCustomerValue => _customerCount;
  String get getCategoryValue => _categoryValue!;
  String get getServiceValue => _serviceValue!;
  String get getNationalityValue => _nationalityValue!;
  String get getSexValue => _sexValue!;
  String get getGroupItemValue => _groupItemValue!;

  num get getCountValue => _countValue;
  List<String> get getServiceItem => _serviceItems;
  List<String> get getCategoryItem => _categoryItems;
  List<String> get getNationalityItem => _nationalityItem;
  List<String> get getSexItem => _sexItem;
  List<String> get getGroupItem => _groupItem;

  bool loading = false;
  SaleModeData? saleModeData;
  OpenTranModel? openTranModel;
  List<SaleModeData>? saleModeDataList;

  init() async {
    _customerCount.text = "1";
    saleModeDataList = [];
    await readSaleModeFile();
  }

  Future openTransaction(BuildContext context, int index) async {
    apisState = ApiState.LOADING;
    try {
      var response = await _homeRepository.openTransaction(
        deviceKey: '0288-7363-6560-2714',
        langID: '1',
        noCustomer: int.parse(_customerCount.text),
        saleModeId: saleModeDataList![index].saleModeID!,
      );
      if (response is Failure) {
        Constants().printCheckFlow(response.code, response.errorResponse);
        _errorText = response.errorResponse.toString();
        apisState = ApiState.ERROR;
      } else {
        openTranModel = OpenTranModel.fromJson(jsonDecode(response));
        if (openTranModel!.responseCode == "") {
          apisState = ApiState.COMPLETED;
        } else {
          _errorText = openTranModel!.responseText;
          apisState = ApiState.ERROR;
        }
      }
    } catch (e, strack) {
      _errorText = strack.toString();
      apisState = ApiState.ERROR;
      Constants().printError('$e - $strack');
    }
  }

  Future readSaleModeFile() async {
    try {
      String? fileResponse =
          await ReadFileFunc().readCoreInit(Constants.SALE_MODE_TXT);
      saleModeDataList = (jsonDecode(fileResponse) as List)
          .map((e) => SaleModeData.fromJson(e))
          .toList();
      Constants().printWarning('Read from file "${Constants.SALE_MODE_TXT}"');
    } catch (e, strack) {
      Constants().printError('$e - $strack');
      _errorText = e.toString();
      apisState = ApiState.ERROR;
    }
    notifyListeners();
  }

  addCount() {
    _countValue++;
    _customerCount.text = _countValue.toString();
    notifyListeners();
  }

  removeCount() {
    if (_countValue > 1) _countValue--;
    _customerCount.text = _countValue.toString();
    notifyListeners();
  }

  setCountText(String value) {
    _countValue = num.parse(value);
    _customerCount.text = value;
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
