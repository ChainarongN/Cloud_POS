import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._internal();
  static final SharedPref _instance = SharedPref._internal();
  factory SharedPref() => _instance;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static const String keyToken = 'token';

  // ----------------------------- set ------------------------------- //

  Future setToken(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keyToken, value);
  }

  // ----------------------------- get ------------------------------- //

  Future<String> getToken() async {
    SharedPreferences prefs = await _prefs;
    String? token = prefs.getString(keyToken);
    return token!;
  }
}
