import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/auth/user_model.dart';

class FirestoreUserService {
  static const String _logTag = 'FirestoreUserService';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _users {
    return _firestore.collection('users');
  }

  /// ==========================
  /// CREATE USER
  /// ==========================
  Future<bool> createUser({
    required String uid,
    required UserModel user,
  }) async {
    try {
      await _users.doc(uid).set({
        'fullName': user.fullName.trim(),
        'email': user.email.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return true;
    } on FirebaseException catch (e, stackTrace) {
      developer.log(
        'createUser error: ${e.code} - ${e.message}',
        name: _logTag,
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    } catch (e, stackTrace) {
      developer.log(
        'createUser error: $e',
        name: _logTag,
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  /// ==========================
  /// GET USER
  /// ==========================
  Future<UserModel?> getUser(String uid) async {
    try {
      final document = await _users.doc(uid).get();

      if (!document.exists) {
        return null;
      }

      final data = document.data();

      if (data == null) {
        return null;
      }

      return UserModel(
        fullName: data['fullName']?.toString() ?? '',
        email: data['email']?.toString() ?? '',
        password: '',
      );
    } on FirebaseException catch (e, stackTrace) {
      developer.log(
        'getUser error: ${e.code} - ${e.message}',
        name: _logTag,
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    } catch (e, stackTrace) {
      developer.log(
        'getUser error: $e',
        name: _logTag,
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// ==========================
  /// UPDATE USER
  /// ==========================
  Future<bool> updateUser({
    required String uid,
    required UserModel user,
  }) async {
    try {
      await _users.doc(uid).update({
        'fullName': user.fullName.trim(),
        'email': user.email.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return true;
    } on FirebaseException catch (e, stackTrace) {
      developer.log(
        'updateUser error: ${e.code} - ${e.message}',
        name: _logTag,
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    } catch (e, stackTrace) {
      developer.log(
        'updateUser error: $e',
        name: _logTag,
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  /// ==========================
  /// DELETE USER
  /// ==========================
  Future<bool> deleteUser(String uid) async {
    try {
      await _users.doc(uid).delete();

      return true;
    } on FirebaseException catch (e, stackTrace) {
      developer.log(
        'deleteUser error: ${e.code} - ${e.message}',
        name: _logTag,
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    } catch (e, stackTrace) {
      developer.log(
        'deleteUser error: $e',
        name: _logTag,
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  /// ==========================
  /// CHECK USER EXISTS
  /// ==========================
  Future<bool> userExists(String uid) async {
    try {
      final document = await _users.doc(uid).get();

      return document.exists;
    } on FirebaseException catch (e, stackTrace) {
      developer.log(
        'userExists error: ${e.code} - ${e.message}',
        name: _logTag,
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    } catch (e, stackTrace) {
      developer.log(
        'userExists error: $e',
        name: _logTag,
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}