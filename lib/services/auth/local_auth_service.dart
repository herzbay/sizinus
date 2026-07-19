import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth/user_model.dart';

class LocalAuthService {

  static const String _userKey =
      'user';

  static const String _loginKey =
      'is_login';

  static const String _onboardingKey =
      'onboarding_completed';

  Future<bool> register(
      UserModel user) async {

      final prefs =
          await SharedPreferences.getInstance();

      final json =
          prefs.getString(_userKey);

      if (json != null) {

        final currentUser =
            UserModel.fromJson(
          jsonDecode(json),
        );

        if (currentUser.email
                .toLowerCase() ==
            user.email.toLowerCase()) {
          return false;
        }
      }

      await prefs.setString(
        _userKey,
        jsonEncode(
          user.toJson(),
        ),
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

  Future<void> deleteAccount() async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(
        _userKey);

    await prefs.remove(
        _loginKey);
  }

  Future<void> updateProfile(UserModel user) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      _userKey,
      jsonEncode(
        user.toJson(),
      ),
    );
  }

  Future<bool> isLoggedIn() async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getBool(
            _loginKey) ??
        false;
  }

  Future<bool> isOnboardingCompleted() async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getBool(
          _onboardingKey,
        ) ??
        false;
  }

  Future<void> completeOnboarding() async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setBool(
      _onboardingKey,
      true,
    );
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

  Future<UserModel?> getUser() async {

    final prefs =
        await SharedPreferences.getInstance();

    final json =
        prefs.getString(
          _userKey,
        );

    if (json == null) {
      return null;
    }

    return UserModel.fromJson(
      jsonDecode(json),
    );
  }
}