import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static Future<void> setTokenPreference(String key, String token) async {
    final pref = await SharedPreferences.getInstance();
    await clearTokenPreference(key);
    pref.setString(key, token);
  }

  static Future<String?> getTokenPreference(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static Future<void> clearTokenPreference(String key) async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey(key)) {
      pref.clear();
    }
  }
}
