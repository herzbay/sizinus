import 'package:flutter/material.dart';

import '../models/auth/user_model.dart';
import '../models/simulation/simulation_data.dart';
import '../data/reward/badge_repository.dart';
import '../models/reward/badge.dart';
import '../services/simulation/local_simulation_storage.dart';

class SessionProvider extends ChangeNotifier {
  static const int pointsPerLevel = 50;

  UserModel? _currentUser;
  SimulationData? _simulationData;

  // ==========================
  // GETTERS
  // ==========================

  UserModel? get currentUser => _currentUser;

  SimulationData? get simulationData => _simulationData;

  bool get isLoggedIn => _currentUser != null;

  List<RewardBadge> get latestBadges {
    if (_simulationData == null) return [];

    final ids = _simulationData!.unlockedBadges;

    return BadgeRepository.allBadges
        .where((badge) => ids.contains(badge.id))
        .take(2)
        .toList();
  }  

  // ==========================
  // COMPUTED PROPERTY
  // ==========================

  int get totalPoint =>
      _simulationData?.totalXp ?? 0;

  int get currentLevel =>
      (totalPoint ~/ pointsPerLevel) + 1;

  double get progress {
    final current =
        totalPoint % pointsPerLevel;

    return current / pointsPerLevel;
  }

  int get badgeCount =>
      _simulationData?.unlockedBadges.length ?? 0;

  int get completedGuideCount =>
      _simulationData?.completedGuideIds.length ?? 0;

  int get historyCount =>
      _simulationData?.historyItems.length ?? 0;

  bool get nibCompleted =>
      _simulationData?.nibCompleted ?? false;

  // ==========================
  // SETTERS
  // ==========================

  void setUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }

  void setSimulation(
    SimulationData? simulation,
  ) {
    _simulationData = simulation;
    notifyListeners();
  }

  /// Dipanggil setiap kali progress simulasi berubah.
  void updateSimulation(
    SimulationData simulation,
  ) {
    _simulationData = simulation;
    notifyListeners();
  }

  /// Dipanggil ketika nama/email user berubah.
  void updateUser(
    UserModel user,
  ) {
    _currentUser = user;
    notifyListeners();
  }

  /// Mengisi seluruh session sekaligus.
  void restoreSession({
    required UserModel user,
    required SimulationData simulation,
  }) {
    _currentUser = user;
    _simulationData = simulation;
    notifyListeners();
  }

  void clear() {
    _currentUser = null;
    _simulationData = null;
    notifyListeners();
  }

  Future<void> refreshSimulation() async {
    if (_currentUser == null) return;

    final simulation =
        await LocalSimulationStorage().load();

    if (simulation == null) return;

    _simulationData = simulation;

    notifyListeners();
  }
}