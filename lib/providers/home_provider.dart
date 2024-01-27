import 'package:cloud_pos/repositorys/home/i_home_repository.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final IHomeRepository _homeRepository;
  HomeProvider(this._homeRepository);

  String? _categoryValue;
  String? _serviceValue;
  String? _nationalityValue = '';
  String? _sexValue = '';
  String? _groupItemValue = 'ALL';
  num _countValue = 1;

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
  List<String> get getDetailGroupItem => _detailGroupItem;

  init() {
    // auth();
  }

  auth() {
    var response = _homeRepository.authToken(
        clientID: 'verticaltec.cloudinventory.dev',
        grantType: 'client_credentials',
        clientSecret: 'acf7e10c71296430');
    print(response);
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
