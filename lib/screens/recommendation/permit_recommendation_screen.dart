import 'package:flutter/material.dart';

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

    if (!mounted) return;

    setState(() {
      simulationData = data;
      isLoading = false;
    });
  }

  void _goToSimulation() {
    Navigator.pushNamed(
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
                      'Selesaikan simulasi NIB terlebih dahulu agar rekomendasi perizinan bisa dibaca dari data usaha yang tersimpan.',
                  actionLabel: actionLabel,
                )
              else if (!isCompleted)
                _buildEmptyState(
                  title: 'Simulasi belum selesai',
                  subtitle:
                      'Selesaikan simulasi NIB terlebih dahulu agar rekomendasi perizinan bisa dihitung dari hasil yang tersimpan.',
                  actionLabel: actionLabel,
                )
              else ...[
                _buildDataSummaryCard(data),
                const SizedBox(height: 16),

                if (recommendations.isNotEmpty) ...[
                  _buildPrimaryRecommendation(
                    recommendations.first,
                  ),

                  if (recommendations.length > 1) ...[
                    const SizedBox(height: 16),
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

              const SizedBox(height: 16),

              _buildInfoCard(),

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
                  'Sistem membaca hasil simulasi NIB lalu menyusun izin yang paling relevan untuk diprioritaskan.',
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

  Widget _buildDataSummaryCard(SimulationData data) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Data Dasar Analisis',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _summaryChip('Kategori', data.businessCategory ?? '-'),
              _summaryChip('KBLI', data.kbli ?? '-'),
              _summaryChip('Skala', data.businessScale ?? '-'),
              _summaryChip('Risiko', data.riskLevel ?? '-'),
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
      sectionTitle: 'Rekomendasi Utama',
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
          color: item.color.withValues(alpha: 0.22),
          width: featured ? 1.4 : 1,
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
                  color: item.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  item.icon,
                  color: item.color,
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
                item.color,
                item.isCompleted,
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
                        color: item.color.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        text,
                        style: TextStyle(
                          color: item.color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
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
    required String actionLabel,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
            Icons.lock_outline,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
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
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blue.shade200,
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Color(0xFF2D9CDB),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informasi Penting',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Rekomendasi ini bersifat rule-based berdasarkan data simulasi yang tersimpan. Nantinya logika ini bisa diganti ke decision tree tanpa mengubah tampilan menu.',
                  style: TextStyle(
                    height: 1.4,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _statusBadge(
    String label,
    Color color,
    bool completed,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: completed
            ? Colors.green.withValues(alpha: 0.1)
            : color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: completed ? Colors.green : color,
        ),
      ),
    );
  }
}