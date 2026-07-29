import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/auth/user_model.dart';

class FirestoreUserService {
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
    } on FirebaseException catch (e) {
      print(
        'Firestore createUser error: '
        '${e.code} - ${e.message}',
      );
      return false;
    } catch (e) {
      print('Firestore createUser error: $e');
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
    } on FirebaseException catch (e) {
      print(
        'Firestore getUser error: '
        '${e.code} - ${e.message}',
      );
      return null;
    } catch (e) {
      print('Firestore getUser error: $e');
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
    } on FirebaseException catch (e) {
      print(
        'Firestore updateUser error: '
        '${e.code} - ${e.message}',
      );
      return false;
    } catch (e) {
      print('Firestore updateUser error: $e');
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
    } on FirebaseException catch (e) {
      print(
        'Firestore deleteUser error: '
        '${e.code} - ${e.message}',
      );
      return false;
    } catch (e) {
      print('Firestore deleteUser error: $e');
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
    } on FirebaseException catch (e) {
      print(
        'Firestore userExists error: '
        '${e.code} - ${e.message}',
      );
      return false;
    } catch (e) {
      print('Firestore userExists error: $e');
      return false;
    }
  }
}