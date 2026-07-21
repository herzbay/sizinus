import 'package:flutter/foundation.dart';

import '../../models/auth/user_model.dart';
import '../../models/simulation/simulation_data.dart';

class UserSession {

  UserSession._();

  static final ValueNotifier<UserModel?>
      currentUserNotifier =
          ValueNotifier(null);

  static final ValueNotifier<SimulationData?>
      simulationNotifier =
          ValueNotifier(null);

  static UserModel? get currentUser =>
      currentUserNotifier.value;

  static SimulationData? get simulation =>
      simulationNotifier.value;

  static bool get isLoggedIn =>
      currentUser != null;

  static void setUser(
    UserModel user,
  ) {

    currentUserNotifier.value =
        user;

  }

  static void setSimulation(
    SimulationData data,
  ) {

    simulationNotifier.value =
        data;

  }

  static void updateSimulation(
    SimulationData data,
  ) {

    simulationNotifier.value =
        data;

  }

  static void clear() {

    currentUserNotifier.value =
        null;

    simulationNotifier.value =
        null;

  }
}