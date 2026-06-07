import 'package:flutter/material.dart';

import '../../data/reward/badge_repository.dart';
import '../../models/recommendation/permit_recommendation_item.dart';
import '../../models/simulation/simulation_data.dart';
import '../../routes/app_routes.dart';
import '../../services/recommendation/permit_recommendation_engine.dart';
import '../../services/simulation/local_simulation_storage.dart';
import '../../widgets/custom_topbar.dart';

class PermitRecommendationScreen extends StatefulWidget {
  const PermitRecommendationScreen({
    super.key,
  });

  @override
  State<PermitRecommendationScreen> createState() =>
      _PermitRecommendationScreenState();
}

class _PermitRecommendationScreenState
    extends State<PermitRecommendationScreen> {
  final LocalSimulationStorage storage =
      LocalSimulationStorage();

  SimulationData? simulationData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await storage.load();

    if (data != null &&
        data.nibCompleted &&
        !data.recommendationRewardClaimed) {
      data.totalXp += BadgeRepository.xpForRecommendationUnlocked();
      data.recommendationRewardClaimed = true;
      await storage.save(data);
    }

    if (!mounted) return;

    setState(() {
      simulationData = data;
      isLoading = false;
    });

    if (data != null &&
        data.nibCompleted &&
        data.recommendationRewardClaimed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Anda mendapatkan +100 XP dari Rekomendasi Perizinan'),
        ),
      );
    }
  }

  void _goToSimulation() {
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.simulationList,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final data = simulationData;
    final hasData = data != null &&
        (data.businessCategory ?? '').trim().isNotEmpty;

    final isCompleted = data?.nibCompleted ?? false;
    final hasProgress = (data?.unlockedStep ?? 1) > 1;

    final recommendations = (hasData && isCompleted)
        ? PermitRecommendationEngine.generate(data)
        : <PermitRecommendationItem>[];

    final String actionLabel = isCompleted
        ? 'Lihat Simulasi'
        : hasProgress
            ? 'Lanjutkan Simulasi'
            : 'Mulai Simulasi';

    return Scaffold(
      appBar: const CustomTopBar(
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),

              const SizedBox(height: 16),

              if (!hasData)
                _buildEmptyState(
                  title: 'Data simulasi belum tersedia',
                  subtitle:
                      'Selesaikan simulasi pembuatan NIB terlebih dahulu agar fitur rekomendasi perizinan bisa dibaca dari data usaha yang tersimpan.',                 
                )
              else if (!isCompleted)
                _buildEmptyState(
                  title: 'Simulasi belum selesai',
                  subtitle:
                      'Selesaikan simulasi pembuatan NIB terlebih dahulu agar fitur rekomendasi perizinan bisa dihitung dari hasil yang tersimpan.',
                )
              else ...[
                _buildDataSummaryCard(data),
                const SizedBox(height: 16),

                if (recommendations.isNotEmpty) ...[
                  const SizedBox(height: 24),

                  const Text(
                    'Rekomendasi Utama',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _buildPrimaryRecommendation(
                    recommendations.first,
                  ),

                  if (recommendations.length > 1) ...[
                    const SizedBox(height: 28),
                    const Text(
                      'Rekomendasi Lanjutan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...recommendations.skip(1).map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: 12,
                            ),
                            child: _buildRecommendationCard(
                              item,
                            ),
                          ),
                        ),
                  ],
                ] else
                  _buildNoRecommendationState(),
              ],

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _goToSimulation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D9CDB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    actionLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue.shade200,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.fact_check_outlined,
            color: Color(0xFF2D9CDB),
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rekomendasi Perizinan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Sistem membaca hasil simulasi pembuatan NIB lalu menyusun izin yang paling relevan untuk diprioritaskan.',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataSummaryCard(
    SimulationData data,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              const Icon(
                Icons.analytics_outlined,
                color: Color(0xFF2D9CDB),
                size: 20,
              ),

              const SizedBox(width: 8),

              const Text(
                'Data Dasar Analisis',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            'Data yang digunakan untuk menyusun rekomendasi perizinan.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 14),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [

              _summaryChip(
                'Kategori',
                data.businessCategory ?? '-',
              ),

              _summaryChip(
                'KBLI',
                data.kbli ?? '-',
              ),

              _summaryChip(
                'Skala',
                data.businessScale ?? '-',
              ),

              _summaryChip(
                'Risiko',
                data.riskLevel ?? '-',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryRecommendation(PermitRecommendationItem item) {
    return _buildRecommendationCard(
      item,
      featured: true,
      sectionTitle: null,
    );
  }

  Widget _buildRecommendationCard(
    PermitRecommendationItem item, {
    bool featured = false,
    String? sectionTitle,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(featured ? 18 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: featured
              ? Colors.green.shade300
              : Colors.orange.shade300,
          width: 1.3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sectionTitle != null) ...[
            Text(
              sectionTitle,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: featured
                      ? Colors.green.shade50
                      : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  item.icon,
                  color: featured
                      ? Colors.green
                      : Colors.deepOrange,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _statusBadge(
                item.statusLabel,
                featured,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            item.reason,
            style: const TextStyle(
              height: 1.45,
            ),
          ),
          if (item.highlights.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: item.highlights
                  .map(
                    (text) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        text,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNoRecommendationState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 42,
            color: Colors.green.shade400,
          ),
          const SizedBox(height: 12),
          const Text(
            'Semua rekomendasi utama sudah terpenuhi',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Data simulasi yang tersimpan sudah cukup lengkap untuk kategori usaha ini.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required String title,
    required String subtitle,
  }) {
    return Column(
      children: [

        Image.asset(
          'assets/images/icon_lock.png',
          height: 180,
          fit: BoxFit.contain,
        ),

        const SizedBox(height: 20),

        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Column(
            children: [

              Text(
                title,
                textAlign:
                    TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                subtitle,
                textAlign:
                    TextAlign.center,
                style: TextStyle(
                  color:
                      Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _summaryChip(
    String label,
    String value,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: Colors.blue.shade100,
        ),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(
          fontSize: 12,
          fontWeight:
              FontWeight.w600,
        ),
      ),
    );
  }

  Widget _statusBadge(
    String label,
    bool featured,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: featured
            ? Colors.green.shade50
            : Colors.orange.shade50,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight:
              FontWeight.bold,
          color: featured
              ? Colors.green
              : Colors.deepOrange,
        ),
      ),
    );
  }
}