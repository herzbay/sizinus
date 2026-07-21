import '../../models/auth/user_model.dart';
import '../../models/simulation/simulation_data.dart';

class UserSession {

  UserSession._();

  static UserModel? currentUser;

  static SimulationData? simulation;

  static bool get isLoggedIn =>
      currentUser != null;

  static void setUser(
    UserModel user,
  ) {
    currentUser = user;
  }

  static void setSimulation(
    SimulationData data,
  ) {
    simulation = data;
  }

  static void clear() {

    currentUser = null;

    simulation = null;
  }

}