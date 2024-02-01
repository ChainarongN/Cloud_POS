import 'package:cloud_pos/models/code_init_model.dart';
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
  List<Products>? prodList;
  List<Products>? prodToShow;
  List<Products>? prodToSearch;
  int? _valueSelect;

  String _exceptionText = '';
  List get getOrderItem => _orderItem;
  String get getExceptionText => _exceptionText;
  int get getvalueSelect => _valueSelect!;

  init() async {
    prodGroupList = [];
    prodList = [];
    prodToSearch = [];
    await _readData();
    setWhereMenu(prodGroupList![0].productGroupID.toString());

    notifyListeners();
  }

  Future _readData() async {
    apiState = ApiState.LOADING;
    try {
      var value = await Future.wait([
        ReadFileFunc().readProdGroup(),
        ReadFileFunc().readProd(),
      ]);
      prodGroupList = value[0] as List<ProductGroup>;
      prodList = value[1] as List<Products>;
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
    _valueSelect = int.parse(value);
    prodToShow = prodList!
        .where((e) => e.productGroupID.toString().toLowerCase().contains(value))
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
