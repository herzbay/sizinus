import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/simulation/simulation_data.dart';

import 'simulation_storage_service.dart';

class LocalSimulationStorage
    implements SimulationStorageService {

  static const String key =
      'nib_simulation_data';

  @override
  Future<void> save(
    SimulationData data,
  ) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      key,
      jsonEncode(
        data.toJson(),
      ),
    );
  }

  @override
  Future<SimulationData?> load() async {

    final prefs =
        await SharedPreferences.getInstance();

    final raw =
        prefs.getString(key);

    if (raw == null) {
      return null;
    }

    return SimulationData.fromJson(
      jsonDecode(raw),
    );
  }

  @override
  Future<void> clear() async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(key);
  }
}