import 'package:bestwe2_0/app_State/token_manager.dart';
import 'package:bestwe2_0/model/UserModel.dart';
import 'package:dio/dio.dart';


class AuthService {
  final Dio _dio;
  final String baseUrl;
  final String apiKey;

  AuthService({
    required Dio dio,
    required this.baseUrl,
    required this.apiKey,
  }) : _dio = dio;

  // Common helper method
  Options _formOptions() => Options(contentType: Headers.formUrlEncodedContentType);

  void _logError(String tag, dynamic error) {
    print('[$tag] Error: $error');
    if (error is DioException && error.response != null) {
      print('[$tag] Response: ${error.response?.data}');
    }
  }

  //================== LOGIN ==================
  Future<Usermodel?> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/login/',
        data: {'email': email, 'password': password},
        options: _formOptions(),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        print('Login Response: $data');

        if (data['user'] != null && data['message'] == "Login successful") {
          final token = data['access'];
          if (token != null) {
            await TokenManager.saveToken(token, _dio);
          }
          return Usermodel.fromJson(data['user']);
        }

        print('Login failed: ${data['message']}');
      }
    } catch (e) {
      _logError('LOGIN', e);
    }
    return null;
  }

  //================== SIGN UP ==================
  Future<Usermodel?> registration(String name, String email, int phone, String password) async {
    try {
      final response = await _dio.post(
        '/sign-up/',
        data: {
          'full_name': name,
          'email': email,
          'mobile': phone.toString(),
          'password': password,
        },
        options: _formOptions(),
      );

      print('Signup Response: ${response.data}');

      if (response.statusCode == 201) {
        return Usermodel(
          full_name: name,
          email: email,
          mobile: phone,
          address: '',
          age: 0,
          status: 'Active',
          image: '',
        );
      }
      throw Exception(response.data['message'] ?? 'Signup failed');
    } catch (e) {
      _logError('SIGNUP', e);
      return null;
    }
  }

  //================== SEND OTP ==================
  Future<bool> sendOtp(String email) async {
    try {
      final response = await _dio.post(
        '/send-otp/',
        data: {'email': email},
        options: _formOptions(),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return true;
      }
      print('Send OTP failed: ${response.data['message']}');
    } catch (e) {
      _logError('SEND OTP', e);
    }
    return false;
  }

  //================== VERIFY OTP ==================
  Future<bool> verifyOtp(String email, String otp) async {
    try {
      final response = await _dio.post(
        '/verify-otp/',
        data: {'email': email.trim(), 'otp': otp.trim()},
        options: _formOptions(),
      );

      if (response.statusCode == 200) {
        final message = response.data['message']?.toString().toLowerCase() ?? '';
        return message.contains('verified');
      }
    } catch (e) {
      _logError('VERIFY OTP', e);
    }
    return false;
  }

  //================== RESET PASSWORD (FORGOT) ==================
  Future<bool> resetPassword({required String email, required String otp, required String newPassword,}) async {
    try {
      final response = await _dio.post(
        '/reset-password/',
        data: {
          'email': email.trim(),
          'otp': otp.trim(),
          'new_password': newPassword.trim(),
        },
        options: _formOptions(),
      );

      if (response.statusCode == 200 && response.data['message'].toString().toLowerCase().contains('reset')) {
        return true;
      }
      print('⚠️ Reset Password failed: ${response.data}');
    } catch (e) {
      _logError('RESET PASSWORD', e);
    }
    return false;
  }

  //================== CHANGE PASSWORD (LOGGED IN USER) ==================
  Future<bool> changeOldPassword({required String oldPassword, required String newPassword1, required String newPassword2,}) async {
    print('Changing password...');

    try {
      final token = await TokenManager.getToken();
      if (token == null) {
        print('❌ No token found in SharedPreferences');
        return false;
      }

      final response = await _dio.put(
        '/update-password/',
        data: {
          'old_password': oldPassword,
          'new_password1': newPassword1,
          'new_password2': newPassword2,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('✅ Change Password Response: ${response.data}');
      return response.statusCode == 200;
    } catch (e) {
      _logError('CHANGE PASSWORD', e);
      if (e is DioException && e.response != null) {
        print('❌ Server error details: ${e.response?.data}');
      }
      return false;
    }
  }

}