import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class TokenManager {
  static const _key = 'auth_token';

  // Get token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  static Future<void> saveToken(String token, Dio dio) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, token);
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  static Future<String?> loadToken(Dio dio) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_key);
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    return token;
  }

  static Future<void> clearToken(Dio dio) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    dio.options.headers.remove('Authorization');
  }
}
