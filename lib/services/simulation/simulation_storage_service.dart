import '../../models/simulation/simulation_data.dart';

abstract class SimulationStorageService {

  Future<void> save(
    SimulationData data,
  );

  Future<SimulationData?> load();

  Future<void> clear();
}