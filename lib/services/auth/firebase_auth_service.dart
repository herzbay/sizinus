import 'package:firebase_auth/firebase_auth.dart';

import '../../models/auth/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// ==========================
  /// REGISTER
  /// ==========================
  Future<bool> register(UserModel user) async {
    try {
      final credential =
          await _auth.createUserWithEmailAndPassword(
        email: user.email.trim(),
        password: user.password,
      );

      await credential.user?.updateDisplayName(
        user.fullName,
      );

      await credential.user?.reload();

      return true;
    } on FirebaseAuthException {
      return false;
    } catch (_) {
      return false;
    }
  }

  /// ==========================
  /// LOGIN
  /// ==========================
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      return true;
    } on FirebaseAuthException {
      return false;
    } catch (_) {
      return false;
    }
  }

  /// ==========================
  /// LOGOUT
  /// ==========================
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// ==========================
  /// DELETE ACCOUNT
  /// ==========================
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;

    if (user != null) {
      await user.delete();
    }
  }

  /// ==========================
  /// UPDATE PROFILE
  /// ==========================
  Future<bool> updateProfile(UserModel user) async {
    try {
      final firebaseUser = _auth.currentUser;

      if (firebaseUser == null) {
        return false;
      }

      await firebaseUser.updateDisplayName(
        user.fullName,
      );

      await firebaseUser.reload();

      return true;
    } on FirebaseAuthException {
      return false;
    } catch (_) {
      return false;
    }
  }

  /// ==========================
  /// LOGIN STATUS
  /// ==========================
  Future<bool> isLoggedIn() async {
    return _auth.currentUser != null;
  }

  /// ==========================
  /// CURRENT USER
  /// ==========================
  Future<UserModel?> getCurrentUser() async {
    final firebaseUser = _auth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    return UserModel(
      fullName: firebaseUser.displayName ?? '',
      email: firebaseUser.email ?? '',
      password: '',
    );
  }

  /// ==========================
  /// GET USER
  /// ==========================
  Future<UserModel?> getUser() async {
    return getCurrentUser();
  }

  /// ==========================
  /// CURRENT USER UID
  /// ==========================
  String? getCurrentUserUid() {
    return _auth.currentUser?.uid;
  }
}