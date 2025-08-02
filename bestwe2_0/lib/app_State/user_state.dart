import 'dart:io';
import 'package:bestwe2_0/model/UserModel.dart';
import 'package:bestwe2_0/services/user_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class UserState extends ChangeNotifier {
  final UserServices _userService;
  final Dio _dio;
  final String _apiKey;

  UserState(this._userService, this._dio, this._apiKey);

  List<Usermodel> _userList = [];
  List<Usermodel> get userList => _userList;

  bool get isLoggedIn => _userList.isNotEmpty;

  
  Future<void> fetchUser() async {
    try {
      final response = await _dio.get('/profile/', options: Options(headers: _buildHeaders()));
      if (response.statusCode == 200) {
        _userList = [Usermodel.fromJson(response.data)];
        notifyListeners();
      }
    } catch (e) {
      print('Fetch user error: $e');
    }
  }

  Future<Map<String, dynamic>> updateUser(Usermodel user, {File? imageFile}) async {
    final response = await _userService.updatedata<Usermodel>(
      url: '/profile/',
      model: user,
      toJson: (u) => u.toJson(),
      method: 'PATCH',
      imagefile: imageFile,
    );
    return response;
  }

  Future<void> deleteUser() async {
    await _userService.delete(url: '/delete-account/');
    _userList = [];
    notifyListeners();
  }

  Future<Map<String, dynamic>> sendMessage(Map<String, dynamic> body) async {
    try {
      final response = await _dio.post(
        '/chat/start/',
        data: body,
        options: Options(headers: _buildHeaders()),
      );
      return response.data;
    } catch (e) {
      print('Send message error: $e');
      return {};
    }
  }


Future<Map<String, dynamic>> continueChat({required String sessionId, required String message}) async {
  try {
    final response = await _dio.post(
      '/chat/respond/',
      queryParameters: {
        'session_id': sessionId, // ✅ Move it here
      },
      data: {
        "session_id": sessionId,
        "message": message,
      },
    );
    print('Response from /chat/respond/: $response');
    return response.data;
  } catch (e) {
    print('Continue chat error: $e');
    return {};
  }
}

  Map<String, String> _buildHeaders() => {
    'Authorization': 'Bearer $_apiKey',
    'Accept': 'application/json',
  };
  
}

