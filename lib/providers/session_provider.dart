import 'package:flutter/material.dart';

import '../models/auth/user_model.dart';
import '../models/simulation/simulation_data.dart';

class SessionProvider extends ChangeNotifier {

  UserModel? _currentUser;

  SimulationData? _simulationData;

  UserModel? get currentUser =>
      _currentUser;

  SimulationData? get simulationData =>
      _simulationData;

  bool get isLoggedIn =>
      _currentUser != null;

  void setUser(
    UserModel? user,
  ) {
    _currentUser = user;
    notifyListeners();
  }

  void setSimulation(
    SimulationData? simulation,
  ) {
    _simulationData = simulation;
    notifyListeners();
  }

  void clear() {
    _currentUser = null;
    _simulationData = null;
    notifyListeners();
  }
}