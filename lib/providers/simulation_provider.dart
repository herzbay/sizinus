import 'package:flutter/foundation.dart';

import '../data/reward/badge_repository.dart';
import '../models/reward/badge.dart';
import '../models/simulation/simulation_data.dart';
import '../services/auth/firebase_auth_service.dart';
import '../services/simulation/firestore_simulation_service.dart';

class SimulationProvider extends ChangeNotifier {
  final FirestoreSimulationService _simulationService =
      FirestoreSimulationService();

  final FirebaseAuthService _authService =
      FirebaseAuthService();

  SimulationData _simulation = SimulationData();

  bool _isLoading = false;

  static const int pointsPerLevel = 50;

  // ==========================
  // GETTERS
  // ==========================

  SimulationData get simulation => _simulation;

  bool get isLoading => _isLoading;

  int get totalPoint => _simulation.totalXp;

  int get currentLevel =>
      (totalPoint ~/ pointsPerLevel) + 1;

  double get progress {
    final current =
        totalPoint % pointsPerLevel;

    return current / pointsPerLevel;
  }

  int get badgeCount =>
      _simulation.unlockedBadges.length;

  int get completedGuideCount =>
      _simulation.completedGuideIds.length;

  int get historyCount =>
      _simulation.historyItems.length;

  bool get nibCompleted =>
      _simulation.nibCompleted;

  List<RewardBadge> get latestBadges {
    final ids = _simulation.unlockedBadges;

    return BadgeRepository.allBadges
        .where((badge) => ids.contains(badge.id))
        .take(2)
        .toList();
  }

  // ==========================
  // LOAD
  // ==========================

  Future<void> loadSimulation() async {
    final uid =
        _authService.getCurrentUserUid();

    if (uid == null) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    await _simulationService.createIfNotExists(
      uid: uid,
    );

    final data =
        await _simulationService.getSimulation(
      uid: uid,
    );

    if (data != null) {
      _simulation = data;
    }

    _isLoading = false;
    notifyListeners();
  }

  // ==========================
  // SAVE
  // ==========================

  Future<bool> saveSimulation() async {
    final uid =
        _authService.getCurrentUserUid();

    if (uid == null) {
      return false;
    }

    return await _simulationService.updateSimulation(
      uid: uid,
      simulation: _simulation,
    );
  }

  // ==========================
  // UPDATE
  // ==========================

  void setSimulation(
    SimulationData simulation,
  ) {
    _simulation = simulation;
    notifyListeners();
  }

  void updateSimulation(
    SimulationData simulation,
  ) {
    _simulation = simulation;
    notifyListeners();
  }

  /// Pengganti restoreSession() pada SessionProvider
  void restoreSimulation(
    SimulationData simulation,
  ) {
    _simulation = simulation;
    notifyListeners();
  }

  /// Memanggil notify tanpa mengubah data.
  void notifySimulationChanged() {
    notifyListeners();
  }

  // ==========================
  // RESET
  // ==========================

  void clear() {
    _simulation = SimulationData();
    _isLoading = false;
    notifyListeners();
  }
}