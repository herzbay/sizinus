import '../../models/simulation/simulation_data.dart';
import 'adaptive_learning_node.dart';

class AdaptiveLearningEngine {
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

    final hasNpwp =
        _isYes(data.hasNpwp);

    final hasHalal =
        _isYes(data.hasHalalCertificate);

    final hasSni =
        _isYes(data.hasSni);

    final buildingConstruction =
        (data.buildingConstruction ?? '').trim() ==
            'Ya';

    final completedNib =
        data.nibCompleted;

    final tree = AdaptiveLearningNode(
      condition: () => true,
      children: [

        // ============================================
        // ROOT
        // ============================================

        AdaptiveLearningNode(
          condition: () => true,
          guideIds: const ['nib'],
        ),

        // ============================================
        // Setelah NIB selesai
        // ============================================

        AdaptiveLearningNode(
          condition: () => completedNib,
          children: [

            // NPWP
            AdaptiveLearningNode(
              condition: () => !hasNpwp,
              guideIds: const ['npwp'],
            ),

            // Kuliner
            AdaptiveLearningNode(
              condition: () =>
                  category == 'Kuliner',
              children: [

                AdaptiveLearningNode(
                  condition: () => !hasHalal,
                  guideIds: const ['halal'],
                ),

                AdaptiveLearningNode(
                  condition: () =>
                      businessScale == 'Mikro' ||
                      businessScale == 'Kecil',
                  guideIds: const ['pirt'],
                ),
              ],
            ),

            // Manufaktur
            AdaptiveLearningNode(
              condition: () =>
                  category == 'Manufaktur',
              children: [

                AdaptiveLearningNode(
                  condition: () => !hasSni,
                  guideIds: const ['sni'],
                ),
              ],
            ),

            // Risiko usaha
            AdaptiveLearningNode(
              condition: () =>
                  riskLevel == 'Sedang',
              guideIds: const ['standar'],
            ),

            // Bangunan
            AdaptiveLearningNode(
              condition: () =>
                  buildingConstruction,
              guideIds: const ['pbg'],
            ),

            // Hak Merek
            AdaptiveLearningNode(
              condition: () =>
                  (data.businessName ?? '')
                      .trim()
                      .isNotEmpty,
              guideIds: const ['merek'],
            ),
          ],
        ),
      ],
    );

    tree.evaluate(result);

    return result.toList();
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