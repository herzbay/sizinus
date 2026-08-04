import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/simulation/simulation_data.dart';

class FirestoreSimulationService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static const String collection =
      'simulations';

  /// ==========================
  /// CREATE
  /// ==========================
  Future<bool> createSimulation({
    required String uid,
    required SimulationData simulation,
  }) async {
    try {
      await _firestore
          .collection(collection)
          .doc(uid)
          .set(
            simulation.toJson(),
          );

      return true;
    } catch (_) {
      return false;
    }
  }

  /// ==========================
  /// GET
  /// ==========================
  Future<SimulationData?> getSimulation({
    required String uid,
  }) async {
    try {
      final snapshot =
          await _firestore
              .collection(collection)
              .doc(uid)
              .get();

      if (!snapshot.exists) {
        return null;
      }

      return SimulationData.fromJson(
        snapshot.data()!,
      );
    } catch (_) {
      return null;
    }
  }

  /// ==========================
  /// UPDATE
  /// ==========================
  Future<bool> updateSimulation({
    required String uid,
    required SimulationData simulation,
  }) async {
    try {
      await _firestore
          .collection(collection)
          .doc(uid)
          .update(
            simulation.toJson(),
          );

      return true;
    } catch (_) {
      return false;
    }
  }

  /// ==========================
  /// DELETE
  /// ==========================
  Future<bool> deleteSimulation({
    required String uid,
  }) async {
    try {
      await _firestore
          .collection(collection)
          .doc(uid)
          .delete();

      return true;
    } catch (_) {
      return false;
    }
  }

  /// ==========================
  /// CREATE IF NOT EXISTS
  /// ==========================
  Future<void> createIfNotExists({
    required String uid,
  }) async {
    final doc = await _firestore
        .collection(collection)
        .doc(uid)
        .get();

    if (!doc.exists) {
      await _firestore
          .collection(collection)
          .doc(uid)
          .set(
            SimulationData().toJson(),
          );
    }
  }
}