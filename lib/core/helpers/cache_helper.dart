import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefs;

  // static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'token';
  static const _ifFirstTimeKey = 'IfFirstTime';
  static const _ifRemember = 'ifRemember';
  static const _theme = 'isDarkMode';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> put({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await _prefs!.setString(key, value);
    } else if (value is bool) {
      return await _prefs!.setBool(key, value);
    } else if (value is double) {
      return await _prefs!.setDouble(key, value);
    } else {
      return await _prefs!.setInt(key, value);
    }
  }

  static dynamic get({
    required String key,
  }) {
    return _prefs!.get(key);
  }

  static Future<bool> saveIfNotFirstTime() async {
    try {
      return await _prefs?.setBool(_ifFirstTimeKey, false) ?? false;
    } catch (e) {
      return false;
    }
  }

  static bool getIfFirstTime() {
    try {
      return _prefs?.getBool(_ifFirstTimeKey) ?? true;
    } catch (e) {
      return true;
    }
  }

  static Future<bool> saveTheme(bool isDarkMode) async {
    try {
      return await _prefs?.setBool(_theme, isDarkMode) ?? false;
    } catch (e) {
      return false;
    }
  }

  static bool getTheme() {
    try {
      return _prefs?.getBool(_theme) ?? true;
    } catch (e) {
      return true;
    }
  }

  static Future<bool?> saveIfRemember() async {
    try {
      return await _prefs?.setBool(_ifRemember, true);
    } catch (e) {
      return false;
    }
  }

  static bool getIfRemember() {
    try {
      return _prefs?.getBool(_ifRemember) ?? false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> saveToken(String token) async {
    try {
      return await _prefs?.setString(_tokenKey, token) ?? false;
    } catch (e) {
      return false;
    }
  }

  static String getToken() {
    try {
      return _prefs?.getString(_tokenKey) ?? "";
    } catch (e) {
      return "";
    }
  }

  static Future<bool> removeToken() async {
    try {
      return await _prefs?.remove(_tokenKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> clear() async {
    try {
      return await _prefs?.clear() ?? false;
    } catch (e) {
      return false;
    }
  }
}
