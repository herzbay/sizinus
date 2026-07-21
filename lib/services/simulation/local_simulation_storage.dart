import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/simulation/simulation_data.dart';
import 'simulation_storage_service.dart';
import '../auth/local_auth_service.dart';
import '../session/user_session.dart';

class LocalSimulationStorage
    implements SimulationStorageService {

  Future<String> _storageKey() async {
    final user = await LocalAuthService()
        .getCurrentUser();

    if (user == null) {
      return 'nib_simulation_guest';
    }

    return 'nib_simulation_${user.email.toLowerCase()}';
  }

  @override
  Future<void> save(
    SimulationData data,
  ) async {

    final prefs =
        await SharedPreferences.getInstance();

    final key =
        await _storageKey();

    await prefs.setString(
      key,
      jsonEncode(
        data.toJson(),
      ),
    );

    UserSession.updateSimulation(data);
  }

  @override
  Future<SimulationData?> load() async {

    final prefs =
        await SharedPreferences.getInstance();

    final key =
        await _storageKey();

    final raw =
        prefs.getString(key);

    if (raw == null) {
      final data = SimulationData();
        await save(data);

        return data;
    }

    return SimulationData.fromJson(
      jsonDecode(raw),
    );
  }

  @override
  Future<void> clear() async {

    final prefs =
        await SharedPreferences.getInstance();

    final key =
        await _storageKey();

    await prefs.remove(key);
  }
}