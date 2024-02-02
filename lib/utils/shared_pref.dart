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
  static const String keyShopID = 'shopId';
  static const String keyComId = 'comId';
  static const String keySaleDate = 'saleDate';
  static const String keySessionKey = 'sessionKey';

  // ----------------------------- set ------------------------------- //

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

  // ----------------------------- get ------------------------------- //

  Future<String> getSessionKey() async {
    SharedPreferences prefs = await _prefs;
    String? sessionKey = prefs.getString(keySessionKey);
    return sessionKey!;
  }

  Future<String> getSaleDate() async {
    SharedPreferences prefs = await _prefs;
    String? saleDate = prefs.getString(keySaleDate);
    return saleDate!;
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await _prefs;
    String? token = prefs.getString(keyToken);
    return token!;
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
    int? staffId = prefs.getInt(keyStaffID);
    return staffId!;
  }

  Future<int> getShopID() async {
    SharedPreferences prefs = await _prefs;
    int? shopID = prefs.getInt(keyShopID);
    return shopID!;
  }

  Future<int> getComputerID() async {
    SharedPreferences prefs = await _prefs;
    int? computerId = prefs.getInt(keyComId);
    return computerId!;
  }
}
