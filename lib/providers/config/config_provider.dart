import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/menu/functions/read_file_func.dart';
import 'package:cloud_pos/repositorys/config/i_config_repository.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class ConfigProvider extends ChangeNotifier {
  final IConfigRepository _configRepository;
  ConfigProvider(this._configRepository);

  ApiState apisState = ApiState.COMPLETED;
  String _widgetString = 'baseUrl';
  bool _printerSwitch = true;
  bool _newDataSwitch = false;
  String? _printerValue = 'TM-30';
  String? _connectionValue = 'Wifi';
  String? imageTest;
  ShopData? shopData;
  final ScreenshotController _screenshotController = ScreenshotController();
  final TextEditingController deviceIdController = TextEditingController();
  final TextEditingController baseUrlController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String get getWidgetString => _widgetString;
  bool get getprinterSwitch => _printerSwitch;
  bool get getNewDataSwitch => _newDataSwitch;
  String get getPrintValue => _printerValue!;
  String get getConnectionValue => _connectionValue!;
  List<String> get getPrinterList => _printerList;
  List<String> get getConnectList => _connectionList;
  ScreenshotController get getScreenShotController => _screenshotController;

  init(BuildContext context) async {
    _widgetString = 'baseUrl';
    _newDataSwitch = await SharedPref().getNewDataSwitch();
    deviceIdController.text = await SharedPref().getDeviceId();
    baseUrlController.text = await SharedPref().getBaseUrl();
    addressController.text = await SharedPref().getPrinterAddress();
    Constants().printError(deviceIdController.text);
    _readShopData();
  }

  Future _readShopData() async {
    var value = await ReadFileFunc().readShopData();
    shopData = value;
    notifyListeners();
  }

  Future setDeviceID(String deviceID) async {
    await SharedPref().setDeviceId(deviceID);
    deviceIdController.text = await SharedPref().getDeviceId();
    // await SharedPref().setDeviceId('0288-7363-6560-2714');
    notifyListeners();
  }

  Future saveConfigUrl() async {
    await SharedPref().setBaseUrl(baseUrlController.text);
  }

  Future saveConfigPrinter() async {
    SharedPref().setPrinterType(_connectionValue!);
    SharedPref().setPrinterModel(_printerValue!);
    SharedPref().setPrinterAddress(addressController.text);

    String type = await SharedPref().getPrinterType();
    String model = await SharedPref().getPrinterModel();
    String address = await SharedPref().getPrinterAddress();

    Constants().printWarning('$type : $model : $address');
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
    _printerValue = value;
    notifyListeners();
  }

  setConnectionValue(String value) {
    _connectionValue = value;
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

List<String> _printerList = ['TM-30', 'Sunmi'];
List<String> _connectionList = ['Wifi', 'SunmiV2'];
