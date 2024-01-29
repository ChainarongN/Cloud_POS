import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String keyToken = 'token';

  Future setToken(String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(keyToken, value);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await _prefs;
    String? token = prefs.getString(keyToken);
    return token!;
  }
}
