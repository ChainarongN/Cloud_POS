import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/repositorys/config/i_config_repository.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class ConfigProvider extends ChangeNotifier {
  final IConfigRepository _configRepository;
  ConfigProvider(this._configRepository);

  ApiState apisState = ApiState.COMPLETED;
  String _widgetString = 'baseUrl';
  bool _printerSwitch = true;
  bool _newDataSwitch = false;
  String? _printerValue = 'Senor';
  String? _connectionValue = 'Wifi';
  String? imageTest;
  final ScreenshotController _screenshotController = ScreenshotController();
  // WidgetsToImageController controller = WidgetsToImageController();

  String get getWidgetString => _widgetString;
  bool get getprinterSwitch => _printerSwitch;
  bool get getNewDataSwitch => _newDataSwitch;
  String get getPrintValue => _printerValue!;
  String get getConnectionValue => _connectionValue!;
  List<String> get getPrinterList => _printerList;
  List<String> get getConnectList => _connectionList;
  ScreenshotController get getScreenShotController => _screenshotController;

  init() async {
    _widgetString = 'baseUrl';
    _newDataSwitch = await SharedPref().getNewDataSwitch();
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
}

List<String> _printerList = ['Senor', 'Something'];
List<String> _connectionList = ['Wifi', 'Something'];
