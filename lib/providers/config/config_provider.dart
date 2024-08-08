import 'dart:io';

import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/service/read_file_func.dart';
import 'package:cloud_pos/repositorys/config/i_config_repository.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class ConfigProvider extends ChangeNotifier {
  final IConfigRepository _configRepository;
  ConfigProvider(this._configRepository);

  ApiState apisState = ApiState.COMPLETED;
  String _widgetString = 'baseUrl';
  bool _printerSwitch = true;
  bool _newDataSwitch = false;
  String? _printerModelValue;
  String? _connectionTypeValue;
  String? imageTest;
  ShopData? shopData;
  ComputerName? computerName;
  final ScreenshotController _screenshotController = ScreenshotController();
  final TextEditingController deviceIdController = TextEditingController();
  final TextEditingController baseUrlController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String get getWidgetString => _widgetString;
  bool get getprinterSwitch => _printerSwitch;
  bool get getNewDataSwitch => _newDataSwitch;
  String get getPrintModelValue => _printerModelValue!;
  String get getConnectionTypeValue => _connectionTypeValue!;
  List<String> get getPrinterList => _printerModelList;
  List<String> get getConnectList => _connectionTypeList;
  ScreenshotController get getScreenShotController => _screenshotController;

  init(BuildContext context) async {
    _widgetString = 'baseUrl';
    _newDataSwitch = await SharedPref().getNewDataSwitch();
    deviceIdController.text = await SharedPref().getDeviceId();
    baseUrlController.text = await SharedPref().getBaseUrl();
    addressController.text = await SharedPref().getPrinterAddress();
    _connectionTypeValue = await SharedPref().getPrinterType();
    _printerModelValue = await SharedPref().getPrinterModel();
    if (_connectionTypeValue!.isEmpty || _printerModelValue!.isEmpty) {
      _connectionTypeValue = _connectionTypeList.first;
      _printerModelValue = _printerModelList.first;
    }
    saveConfigPrinter();

    Constants().printError(deviceIdController.text);
    _readShopData();
    _readComputerName();
  }

  Future _readShopData() async {
    ShopData? value;
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/${Constants.SHOP_DATA_TXT}');
    bool fileExists = file.existsSync();
    if (fileExists) {
      value = await ReadFileFunc().readShopData();
    }
    shopData = value;
    notifyListeners();
  }

  Future _readComputerName() async {
    ComputerName? value;
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/${Constants.COMPUTER_NAME_TXT}');
    bool fileExists = file.existsSync();
    if (fileExists) {
      value = await ReadFileFunc().readComputerName();
    }
    computerName = value;
    notifyListeners();
  }

  Future setDeviceID(String deviceID) async {
    await SharedPref().setDeviceId(deviceID);
    deviceIdController.text = await SharedPref().getDeviceId();
    notifyListeners();
  }

  Future saveConfigUrl() async {
    await SharedPref().setBaseUrl(baseUrlController.text);
  }

  Future saveConfigPrinter() async {
    SharedPref().setPrinterType(_connectionTypeValue!);
    SharedPref().setPrinterModel(_printerModelValue!);
    SharedPref().setPrinterAddress(addressController.text);
  }

  setWidgetString(String value) {
    _widgetString = value;
    notifyListeners();
  }

  setPrinterSwitch(bool value) {
    _printerSwitch = value;
    notifyListeners();
  }

  setNewDataSwitch(bool value) async {
    _newDataSwitch = value;
    await SharedPref().setNewDataSwitch(value);
    notifyListeners();
  }

  setPrinterValue(String value) {
    _printerModelValue = value;
    notifyListeners();
  }

  setConnectionValue(String value) {
    _connectionTypeValue = value;
    notifyListeners();
  }

  setBaseUrlForTest() {
    // baseUrlController.text = 'https://apicore.vtec-system.com';
    baseUrlController.text = 'https://apicore-inthanin-qas.bangchakretail.com';
    notifyListeners();
  }

  setAddressForTest() {
    addressController.text = '192.168.1.137';
    notifyListeners();
  }
}

List<String> _printerModelList = ['TM-30', 'Sunmi'];
List<String> _connectionTypeList = ['Wifi', 'SunmiV2'];
