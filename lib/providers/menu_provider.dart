import 'dart:convert';

import 'package:cloud_pos/models/cencel_tran_model.dart';
import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/models/reason_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/pages/menu/function/read_file_func.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:flutter/material.dart';

import '../repositorys/repository.dart';

class MenuProvider extends ChangeNotifier {
  final IMenuRepository _menuRepository;
  MenuProvider(this._menuRepository);

  ApiState apiState = ApiState.COMPLETED;
  List<ProductGroup>? prodGroupList;
  List<ReasonGroup>? reasonGroupList;
  List<Products>? prodList;
  List<Products>? prodToShow;
  List<Products>? prodToSearch;
  ReasonModel? reasonModel;
  CancelTranModel? cancelTranModel;

  int? _valueMenuSelect;
  String? _valueReasonGroupSelect;
  String? _orderId = '';
  String _exceptionText = '';
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _valueIdReasonText = TextEditingController();

  String get getOrderId => _orderId!;
  List get getOrderItem => _orderItem;
  String get getExceptionText => _exceptionText;
  int get getvalueMenuSelect => _valueMenuSelect!;
  String get getvalueReasonGroupSelect => _valueReasonGroupSelect!;
  TextEditingController get getReasonController => _reasonController;
  TextEditingController get getvalueReasonText => _valueIdReasonText;

  init() async {
    prodGroupList = [];
    prodList = [];
    prodToSearch = [];
    await _readData();
    await setReason(0);
    setWhereMenu(prodGroupList![0].productGroupID.toString());

    Constants().printWarning("OrderId : $_orderId");
    notifyListeners();
  }

  Future cancelTransaction() async {
    apiState = ApiState.LOADING;
    try {
      var response = await _menuRepository.cancelTran(
          deviceKey: '0288-7363-6560-2714',
          langId: '1',
          orderId: _orderId,
          reasonIDList: _valueIdReasonText.text);
      if (response is Failure) {
        apiState = ApiState.ERROR;
        _exceptionText = response.errorResponse.toString();
        Constants().printError(response.code.toString());
        Constants().printError(response.errorResponse.toString());
      } else {
        // cancelTranModel = CancelTranModel.fromJson(jsonDecode(response));
        apiState = ApiState.COMPLETED;
        Constants().printInfo(response);
        Constants().printWarning('Cancel Transaction');
      }
    } catch (e, strack) {
      apiState = ApiState.ERROR;
      Constants().printError(e.toString());
      Constants().printError(strack.toString());
      _exceptionText = strack.toString();
    }
  }

  Future setReason(int index) async {
    apiState = ApiState.LOADING;
    _valueReasonGroupSelect = reasonGroupList![index].name;
    try {
      var response = await _menuRepository.reason(
          deviceKey: '0288-7363-6560-2714',
          langId: '1',
          reasonId: reasonGroupList![index].iD.toString());

      if (response is Failure) {
        apiState = ApiState.ERROR;
        _exceptionText = response.errorResponse.toString();
        Constants().printError(response.code.toString());
        Constants().printError(response.errorResponse.toString());
      } else {
        reasonModel = ReasonModel.fromJson(jsonDecode(response));
        apiState = ApiState.COMPLETED;
      }
    } catch (e, strack) {
      apiState = ApiState.ERROR;
      Constants().printError(e.toString());
      Constants().printError(strack.toString());
      _exceptionText = strack.toString();
    }

    notifyListeners();
  }

  Future clearReasonText() async {
    _reasonController.text = '';
    _valueIdReasonText.text = '';
    notifyListeners();
  }

  Future addReasonText(int index) async {
    if (_reasonController.text == '' && _valueIdReasonText.text == '') {
      _reasonController.text = reasonModel!.responseObj![index].text!;
      _valueIdReasonText.text = reasonModel!.responseObj![index].iD!.toString();
    } else {
      _reasonController.text += ', ${reasonModel!.responseObj![index].text!}';
      _valueIdReasonText.text +=
          ',${reasonModel!.responseObj![index].iD!.toString()}';
    }
    notifyListeners();
  }

  Future setOrderId(String value) async => _orderId = value;

  Future _readData() async {
    apiState = ApiState.LOADING;
    try {
      var value = await Future.wait([
        ReadFileFunc().readProdGroup(),
        ReadFileFunc().readProd(),
        ReadFileFunc().readReason()
      ]);
      prodGroupList = value[0] as List<ProductGroup>;
      prodList = value[1] as List<Products>;
      reasonGroupList = value[2] as List<ReasonGroup>;
      apiState = ApiState.COMPLETED;
    } catch (e, strack) {
      apiState = ApiState.ERROR;
      _exceptionText = e.toString();
      Constants().printError(e.toString());
      Constants().printError(strack.toString());
    }
  }

  searchMenu(String value) {
    if (value.isEmpty) {
      prodToSearch = [];
    } else {
      prodToSearch = prodList!
          .where(
              (e) => e.productName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  setWhereMenu(String value) {
    _valueMenuSelect = int.parse(value);
    prodToShow = prodList!
        .where((e) => e.productGroupID.toString().contains(value))
        .toList();
    notifyListeners();
  }

  addCountOrder(int index) {
    _orderItem[index]['count']++;
    notifyListeners();
  }

  removeCountOrder(int index) {
    if (_orderItem[index]['count'] > 1) {
      _orderItem[index]['count']--;
    }
    notifyListeners();
  }

  final List _orderItem = [
    {"price": "140", "count": 2, "name": "Hot Americano", "image": ""},
    {"price": "60", "count": 1, "name": "Americano", "image": ""},
    {"price": "60", "count": 1, "name": "Mocha", "image": ""},
  ];
}
