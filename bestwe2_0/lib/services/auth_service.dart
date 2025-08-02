import 'package:bestwe2_0/app_State/auth_service.dart';
import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier {
  final AuthService _auth;
  AuthState(this._auth);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _loginError;
  String? get loginError => _loginError;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    return _runAuthTask(() async {
      final user = await _auth.login(email, password);
      return user != null;
    });
  }

  Future<bool> registration(String username, String email, int mobile, String password) async {
    return _runAuthTask(() async {
      final user = await _auth.registration(username, email, mobile, password);
      return user != null;
    });
  }

  Future<bool> sendOtp(String email) async => _runAuthTask(() => _auth.sendOtp(email));
  Future<bool> verifyOtp({required String email, required String otp}) async => _runAuthTask(() => _auth.verifyOtp(email, otp));
  Future<bool> resetPassword({required String email, required String otp, required String newPassword}) async =>
      _runAuthTask(() => _auth.resetPassword(email: email, otp: otp, newPassword: newPassword));
  Future<bool> changeOldPassword({required String oldPassword, required String new_password1, required String new_password2}) async =>
      _runAuthTask(() => _auth.changeOldPassword(oldPassword: oldPassword, newPassword1: new_password1, newPassword2: new_password2));

  Future<bool> _runAuthTask(Future<bool> Function() task) async {
    _setLoading(true);
    final result = await task();
    _setLoading(false);
    return result;
  }
}