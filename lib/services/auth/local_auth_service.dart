import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth/user_model.dart';

class LocalAuthService {

  static const String _usersKey =
      'users';

  static const String _currentUserKey =
      'current_user_email';

  static const String _loginKey =
      'is_login';

  static const String _onboardingKey =
      'onboarding_completed';

  Future<List<UserModel>> _getUsers() async {

    final prefs =
        await SharedPreferences.getInstance();

    final json =
        prefs.getString(_usersKey);

    if (json == null) {
      return [];
    }

    final List list =
        jsonDecode(json);

    return list
        .map((e) =>
            UserModel.fromJson(e))
        .toList();
  }

  Future<void> _saveUsers(
      List<UserModel> users) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      _usersKey,
      jsonEncode(
        users
            .map((e) => e.toJson(),)
            .toList(),
      ),
    );
  }

  Future<bool> register(
      UserModel user,) async {

    final users =
        await _getUsers();

    final exists =
        users.any(
      (u) => u.email.toLowerCase().trim() == user.email.toLowerCase().trim(),
    );

    if (exists) {
      return false;
    }

    users.add(user);

    await _saveUsers(users);

    return true;
  }

  Future<bool> login({
      required String email,
      required String password,}) async {

    final prefs =
        await SharedPreferences.getInstance();

    final users =
        await _getUsers();
    
    UserModel? user;

    try {
      user = users.firstWhere(
        (u) =>
            u.email.toLowerCase().trim() == email.toLowerCase().trim(),
      );
    } catch (_) {
      return false;
    }

    if (user.password != password) {
      return false;
    }

    await prefs.setBool(
      _loginKey,
      true,
    );

    await prefs.setString(
      _currentUserKey,
      user.email,
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

    await prefs.remove(
      _currentUserKey,
    );
  }

  Future<void> deleteAccount() async {

    final prefs =
        await SharedPreferences.getInstance();

    final email =
        prefs.getString(
          _currentUserKey,
        );

    if (email == null) {
      return;
    }

    final users =
        await _getUsers();

    users.removeWhere(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
    );

    await _saveUsers(users,);
    await prefs.remove(
      _currentUserKey,
    );
    await prefs.setBool(
      _loginKey,
      false,
    );
  }

  Future<void> updateProfile(UserModel user,) async {

    final users =
        await _getUsers();

    final index =
        users.indexWhere(
      (u) => u.email.toLowerCase() == user.email.toLowerCase(),
    );

    if (index == -1) {
      return;
    }

    users[index] = user;
    await _saveUsers(users);
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

    final email =
        prefs.getString(
          _currentUserKey,
        );

    if (email == null) {
      return null;
    }

    final users = await _getUsers();

    try{
      return users.firstWhere((u) => u.email.toLowerCase() == email.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  Future<UserModel?> getUser() async {

    return getCurrentUser();
  }
}