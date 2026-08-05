import 'package:flutter/material.dart';

import '../models/auth/user_model.dart';

class SessionProvider extends ChangeNotifier {
  UserModel? _currentUser;

  // ==========================
  // GETTERS
  // ==========================

  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  // ==========================
  // SETTERS
  // ==========================

  void setUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }

  /// Dipanggil ketika nama/email user berubah.
  void updateUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  void clear() {
    _currentUser = null;
    notifyListeners();
  }
}