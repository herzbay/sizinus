import '../../models/simulation/simulation_data.dart';
import 'decision_tree_node.dart';

class DecisionTreeEngine {
  static List<String> evaluate(
    SimulationData data,
  ) {
    final result = <String>{};

    final category =
        (data.businessCategory ?? '').trim();

    final businessScale =
        (data.businessScale ?? '').trim();

    final riskLevel =
        (data.riskLevel ?? '').trim();

    final businessName =
        (data.businessName ?? '').trim();

    final hasNpwp =
        _isYes(data.hasNpwp);

    final hasHalal =
        _isYes(data.hasHalalCertificate);

    final hasSni =
        _isYes(data.hasSni);

    final buildingConstruction =
        (data.buildingConstruction ?? '')
                .trim() ==
            'Ya';

    final tree = DecisionTreeNode(
      condition: () => true,
      children: [
        _kuliner(
          hasHalal,
          hasNpwp,
          businessScale,
          riskLevel,
          buildingConstruction,
          businessName,
        ),

        _manufaktur(
          hasSni,
          hasNpwp,
          riskLevel,
          buildingConstruction,
          businessName,
        ),

        _defaultCategory(
          category,
          hasNpwp,
          riskLevel,
          buildingConstruction,
          businessName,
        ),
      ],
    );

    tree.evaluate(result);

    return result.toList();
  }

  static DecisionTreeNode _kuliner(
    bool hasHalal,
    bool hasNpwp,
    String businessScale,
    String riskLevel,
    bool buildingConstruction,
    String businessName,
  ) {
    return DecisionTreeNode(
      condition: () => true,
      children: [
        DecisionTreeNode(
          condition: () => !hasHalal,
          ruleIds: ['HALAL'],
        ),

        DecisionTreeNode(
          condition: () =>
              businessScale == 'Mikro' ||
              businessScale == 'Kecil',
          ruleIds: ['PIRT'],
        ),

        DecisionTreeNode(
          condition: () => !hasNpwp,
          ruleIds: ['NPWP'],
        ),

        DecisionTreeNode(
          condition: () =>
              riskLevel == 'Sedang',
          ruleIds: ['STANDAR'],
        ),

        DecisionTreeNode(
          condition: () =>
              buildingConstruction,
          ruleIds: ['PBG'],
        ),

        DecisionTreeNode(
          condition: () =>
              businessName.isNotEmpty,
          ruleIds: ['MEREK'],
        ),
      ],
    );
  }

  static DecisionTreeNode _manufaktur(
    bool hasSni,
    bool hasNpwp,
    String riskLevel,
    bool buildingConstruction,
    String businessName,
  ) {
    return DecisionTreeNode(
      condition: () => true,
      children: [
        DecisionTreeNode(
          condition: () => !hasSni,
          ruleIds: ['SNI'],
        ),

        DecisionTreeNode(
          condition: () => !hasNpwp,
          ruleIds: ['NPWP'],
        ),

        DecisionTreeNode(
          condition: () =>
              riskLevel == 'Sedang',
          ruleIds: ['STANDAR'],
        ),

        DecisionTreeNode(
          condition: () =>
              buildingConstruction,
          ruleIds: ['PBG'],
        ),

        DecisionTreeNode(
          condition: () =>
              businessName.isNotEmpty,
          ruleIds: ['MEREK'],
        ),
      ],
    );
  }

  static DecisionTreeNode _defaultCategory(
    String category,
    bool hasNpwp,
    String riskLevel,
    bool buildingConstruction,
    String businessName,
  ) {
    return DecisionTreeNode(
      condition: () =>
          category != 'Kuliner' &&
          category != 'Manufaktur',
      children: [
        DecisionTreeNode(
          condition: () => !hasNpwp,
          ruleIds: ['NPWP'],
        ),

        DecisionTreeNode(
          condition: () =>
              riskLevel == 'Sedang',
          ruleIds: ['STANDAR'],
        ),

        DecisionTreeNode(
          condition: () =>
              buildingConstruction,
          ruleIds: ['PBG'],
        ),

        DecisionTreeNode(
          condition: () =>
              businessName.isNotEmpty,
          ruleIds: ['MEREK'],
        ),
      ],
    );
  }

  static bool _isYes(
    String? value,
  ) {
    return value
            ?.trim()
            .toLowerCase() ==
        'ya';
  }
}