import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._internal();
  static final SharedPref _instance = SharedPref._internal();
  factory SharedPref() => _instance;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static const String keyToken = 'token';
  static const String keyNewDataSwitch = 'newDataSwitch';
  static const String keyUuid = 'uuid';

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

  // ----------------------------- get ------------------------------- //

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
}
