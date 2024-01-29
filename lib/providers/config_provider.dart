import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/repositorys/config/i_config_repository.dart';
import 'package:flutter/material.dart';

class ConfigProvider extends ChangeNotifier {
  final IConfigRepository _configRepository;
  ConfigProvider(this._configRepository);

  ApiState apisState = ApiState.COMPLETED;
  String _widgetString = 'baseUrl';
  bool _printerStatus = true;
  String? _printerValue = 'Senor';
  String? _connectionValue = 'Wifi';

  String get getWidgetString => _widgetString;
  bool get getprinterStatus => _printerStatus;
  String get getPrintValue => _printerValue!;
  String get getConnectionValue => _connectionValue!;
  List<String> get getPrinterList => _printerList;
  List<String> get getConnectList => _connectionList;

  init() {
    _widgetString = 'baseUrl';
  }

  setWidgetString(String value) {
    _widgetString = value;
    notifyListeners();
  }

  setPrinterStatus(bool value) {
    _printerStatus = value;
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
