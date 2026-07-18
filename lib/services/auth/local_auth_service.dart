import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth/user_model.dart';

class LocalAuthService {

  static const String _userKey =
      'user';

  static const String _loginKey =
      'is_login';

  Future<bool> register(
      UserModel user) async {

    final prefs =
        await SharedPreferences.getInstance();

    final email =
        prefs.getString('email');

    if (email == user.email) {
      return false;
    }

    await prefs.setString(
      _userKey,
      jsonEncode(user.toJson()),
    );

    await prefs.setString(
      'email',
      user.email,
    );

    return true;
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {

    final prefs =
        await SharedPreferences.getInstance();

    final json =
        prefs.getString(_userKey);

    if (json == null) {
      return false;
    }

    final user = UserModel.fromJson(
      jsonDecode(json),
    );

    if (user.email != email) {
      return false;
    }

    if (user.password != password) {
      return false;
    }

    await prefs.setBool(
      _loginKey,
      true,
    );

    return true;
  }

  Future<void> logout() async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setBool(
      _loginKey,
      false,
    );
  }

  Future<bool> isLoggedIn() async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getBool(
            _loginKey) ??
        false;
  }

  Future<UserModel?> getCurrentUser() async {

    final prefs =
        await SharedPreferences.getInstance();

    final json =
        prefs.getString(_userKey);

    if (json == null) {
      return null;
    }

    return UserModel.fromJson(
      jsonDecode(json),
    );
  }
}