import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._internal();
  static final SharedPref _instance = SharedPref._internal();
  factory SharedPref() => _instance;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static const String keyToken = 'token';
  static const String keyNewDataSwitch = 'newDataSwitch';
  static const String keyUuid = 'uuid';
  static const String keyStaffID = 'staffId';
  static const String keyStaffCode = 'staffCode';
  static const String keyStaffRoleName = 'StaffRoleName';
  static const String keyShopID = 'shopId';
  static const String keyComId = 'comId';
  static const String keySaleDate = 'saleDate';
  static const String keySessionKey = 'sessionKey';
  static const String keyOpenTokenDay = 'openTokenDay';
  static const String orderId = 'orderId';
  static const String username = 'username';
  static const String appVersion = 'appVersion';
  static const String deviceId = 'deviceId';
  static const String keyBaseUrl = 'baseUrl';
  static const String keyResponsiveDevice = 'ResponsiveDevice';
  static const String keyPrinterModel = 'printerModel';
  static const String keyPrinterType = 'printerType';
  static const String keyPrinterAddress = 'printerAddress';
  static const String keyPrinterReceipt = 'printerReceipt';
  static const String keyPrinterNameUSB = 'PrinterNameUSB';
  static const String keyPrinterProdIdUSB = 'PrinterProdIdUSB';
  static const String keyPrinterVendorIdUSB = 'PrinterVendorIdUSB';

  // ----------------------------- set ------------------------------- //
  Future setPrinterNameUSB(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keyPrinterNameUSB, value);
  }

  Future setPrinterProdIdUSB(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keyPrinterProdIdUSB, value);
  }

  Future setPrinterVendorIdUSB(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keyPrinterVendorIdUSB, value);
  }

  Future setPrinterReceipt(bool value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setBool(keyPrinterReceipt, value);
  }

  Future setPrinterModel(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keyPrinterModel, value);
  }

  Future setPrinterAddress(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keyPrinterAddress, value);
  }

  Future setPrinterType(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keyPrinterType, value);
  }

  Future setResponsiveDevice(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keyResponsiveDevice, value);
  }

  Future setAppVersion(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(appVersion, value);
  }

  Future setUsername(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(username, value);
  }

  Future setOrderId(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(orderId, value);
  }

  Future setOpenTokenDay(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keyOpenTokenDay, value);
  }

  Future setToken(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keyToken, value);
  }

  Future setUuid(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keyUuid, value);
  }

  Future setNewDataSwitch(bool value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setBool(keyNewDataSwitch, value);
  }

  Future setStaffID(int value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setInt(keyStaffID, value);
  }

  Future setShopID(int value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setInt(keyShopID, value);
  }

  Future setComputerID(int value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setInt(keyComId, value);
  }

  Future setSaleDate(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keySaleDate, value);
  }

  Future setSessionKey(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keySessionKey, value);
  }

  Future setDeviceId(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(deviceId, value);
  }

  Future setStaffCode(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keyStaffCode, value);
  }

  Future setStaffRoleName(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keyStaffRoleName, value);
  }

  Future setBaseUrl(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keyBaseUrl, value);
  }

  // ----------------------------- get ------------------------------- //

  Future<String> getPrinterNameUSB() async {
    SharedPreferences prefs = await _prefs;
    String? result = prefs.getString(keyPrinterNameUSB) ?? '';
    return result;
  }

  Future<String> getPrinterProdIdUSB() async {
    SharedPreferences prefs = await _prefs;
    String? result = prefs.getString(keyPrinterProdIdUSB) ?? '';
    return result;
  }

  Future<String> getPrinterVendorIdUSB() async {
    SharedPreferences prefs = await _prefs;
    String? result = prefs.getString(keyPrinterVendorIdUSB) ?? '';
    return result;
  }

  Future<bool> getPrinterReceipt() async {
    SharedPreferences prefs = await _prefs;
    bool? result = prefs.getBool(keyPrinterReceipt) ?? true;
    return result;
  }

  Future<String> getPrinterAddress() async {
    SharedPreferences prefs = await _prefs;
    String? result = prefs.getString(keyPrinterAddress) ?? '';
    return result;
  }

  Future<String> getPrinterType() async {
    SharedPreferences prefs = await _prefs;
    String? result = prefs.getString(keyPrinterType) ?? '';
    return result;
  }

  Future<String> getPrinterModel() async {
    SharedPreferences prefs = await _prefs;
    String? result = prefs.getString(keyPrinterModel) ?? '';
    return result;
  }

  Future<String> getResponsiveDevice() async {
    SharedPreferences prefs = await _prefs;
    String? result = prefs.getString(keyResponsiveDevice) ?? '';
    return result;
  }

  Future<String> getBaseUrl() async {
    SharedPreferences prefs = await _prefs;
    String? result = prefs.getString(keyBaseUrl) ?? '';
    return result;
  }

  Future<String> getStaffRoleName() async {
    SharedPreferences prefs = await _prefs;
    String? result = prefs.getString(keyStaffRoleName) ?? '';
    return result;
  }

  Future<String> getStaffCode() async {
    SharedPreferences prefs = await _prefs;
    String? result = prefs.getString(keyStaffCode) ?? '';
    return result;
  }

  Future<String> getDeviceId() async {
    SharedPreferences prefs = await _prefs;
    String? result = prefs.getString(deviceId) ?? '';
    return result;
  }

  Future<String> getAppVersion() async {
    SharedPreferences prefs = await _prefs;
    String? result = prefs.getString(appVersion) ?? '';
    return result;
  }

  Future<String> getUsername() async {
    SharedPreferences prefs = await _prefs;
    String? result = prefs.getString(username) ?? '';
    return result;
  }

  Future<String> getOrderId() async {
    SharedPreferences prefs = await _prefs;
    String? result = prefs.getString(orderId) ?? '';
    return result;
  }

  Future<String> getOpenTokenDay() async {
    SharedPreferences prefs = await _prefs;
    String? result = prefs.getString(keyOpenTokenDay) ?? '';
    return result;
  }

  Future<String> getSessionKey() async {
    SharedPreferences prefs = await _prefs;
    String? sessionKey = prefs.getString(keySessionKey) ?? '';
    return sessionKey;
  }

  Future<String> getSaleDate() async {
    SharedPreferences prefs = await _prefs;
    String? saleDate = prefs.getString(keySaleDate);
    return saleDate!;
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await _prefs;
    String? token = prefs.getString(keyToken) ?? '';
    return token;
  }

  Future<String> getUuid() async {
    SharedPreferences prefs = await _prefs;
    String? uuid = prefs.getString(keyUuid);
    return uuid ?? '';
  }

  Future<bool> getNewDataSwitch() async {
    SharedPreferences prefs = await _prefs;
    bool? token = prefs.getBool(keyNewDataSwitch) ?? false;
    return token;
  }

  Future<int> getStaffID() async {
    SharedPreferences prefs = await _prefs;
    int? staffId = prefs.getInt(keyStaffID) ?? 0;
    return staffId;
  }

  Future<int> getShopID() async {
    SharedPreferences prefs = await _prefs;
    int? shopID = prefs.getInt(keyShopID) ?? 0;
    return shopID;
  }

  Future<int> getComputerID() async {
    SharedPreferences prefs = await _prefs;
    int? computerId = prefs.getInt(keyComId) ?? 0;
    return computerId;
  }
}
