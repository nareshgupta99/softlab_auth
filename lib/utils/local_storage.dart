import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<String?>? getStringData({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(key);
    return token;
  }

  static void setStringData({required String key, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static void setBolleanData({required String key, required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool?>? getBooleanData({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getBool(key);
    return token;
  }

  static Future<void> clearLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
