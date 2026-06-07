import 'package:flutter/material.dart';

import '../../models/guide/guide_item.dart';
import '../../models/simulation/simulation_data.dart';
import '../../routes/app_routes.dart';
import '../../services/guide/business_guide_engine.dart';
import '../../services/simulation/local_simulation_storage.dart';
import '../../widgets/custom_topbar.dart';
import 'business_guide_detail_screen.dart';

enum GuideCardType {
  basic,
  personalized,
  other,
}

class BusinessGuideScreen extends StatefulWidget {
  const BusinessGuideScreen({
    super.key,
  });

  @override
  State<BusinessGuideScreen> createState() =>
      _BusinessGuideScreenState();
}

class _BusinessGuideScreenState
    extends State<BusinessGuideScreen> {
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
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.simulationList,
    );
  }

  void _openGuide(GuideItem item) {
    if (!item.isUnlocked) {
      _showLockedDialog(item);
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BusinessGuideDetailScreen(
          guideItem: item,
        ),
      ),
    );
  }

  void _showLockedDialog(GuideItem item) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Panduan Terkunci'),
          content: Text(
            '${item.title} akan terbuka setelah simulasi NIB selesai.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tutup'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _goToSimulation();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D9CDB),
              ),
              child: const Text(
                'Mulai Simulasi',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
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

    final guides = BusinessGuideEngine.generate(data);
    final nibGuide = guides.firstWhere((e) => e.id == 'nib');
    final otherGuides = guides.where((e) => e.id != 'nib').toList();

    final unlockedGuides =
        otherGuides.where((e) => e.isUnlocked).toList();

    final lockedGuides =
        otherGuides.where((e) => !e.isUnlocked).toList();

    final personalizedGuideIds = [
      'halal',
      'pirt',
      'sni',
      'standar',
      'merek',
      'pbg',
    ];

    final personalizedGuides =
        unlockedGuides.where(
          (e) =>
              personalizedGuideIds.contains(
                e.id,
              ),
        ).toList();

    final otherAvailableGuides =
        unlockedGuides.where(
          (e) =>
              !personalizedGuideIds.contains(
                e.id,
              ),
        ).toList();

    final String actionLabel = isCompleted
        ? 'Lihat Simulasi'
        : hasProgress
            ? 'Lanjutkan Simulasi'
            : 'Mulai Simulasi';

    final String infoText = isCompleted
        ? 'Panduan lanjutan dibuka berdasarkan data simulasi NIB yang sudah selesai.'
        : 'Panduan NIB tersedia untuk semua pengguna. Panduan lainnya akan terbuka setelah simulasi NIB selesai.';

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

              if (hasData) ...[
                _buildDataSummaryCard(data),
                const SizedBox(height: 16),
              ],

              const Text(
                'Panduan Dasar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _buildGuideCard(
                nibGuide,
                cardType:
                    GuideCardType.basic,
              ),

              if (personalizedGuides.isNotEmpty) ...[
                const SizedBox(height: 28),

                const Text(
                  'Panduan Sesuai Usaha Anda',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Disusun berdasarkan hasil simulasi yang telah Anda selesaikan.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 12),

                ...personalizedGuides.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: _buildGuideCard(
                      item,
                      cardType: GuideCardType.personalized,
                    ),
                  ),
                ),
              ],

              if (otherAvailableGuides.isNotEmpty) ...[
                const SizedBox(height: 28),

                const Text(
                  'Panduan Lainnya',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Panduan tambahan yang dapat dipelajari kapan saja.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 12),

                ...otherAvailableGuides.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: _buildGuideCard(
                      item,
                      cardType: GuideCardType.other,
                    ),
                  ),
                ),
              ],

              if (lockedGuides.isNotEmpty) ...[
                const SizedBox(height: 28),

                const Text(
                  'Panduan Terkunci',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                ...lockedGuides.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: _buildGuideCard(
                      item,
                      cardType: GuideCardType.other,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 18),

              _buildInfoCard(infoText),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
          child: SizedBox(
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Panduan Usaha',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Panduan belajar yang disesuaikan dengan kebutuhan usaha Anda.',
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Data yang digunakan untuk menyusun panduan usaha.',
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

  Widget _buildGuideCard(
    GuideItem item, {
    GuideCardType cardType =
        GuideCardType.basic,
  }) {

    final bool locked =
        !item.isUnlocked;

    Color borderColor;
    Color iconColor;
    Color bgColor;

    if (locked) {

      borderColor =
          Colors.grey.shade300;

      iconColor =
          Colors.grey.shade500;

      bgColor =
          Colors.grey.shade100;

    } else if (
        cardType ==
        GuideCardType.basic) {

      borderColor =
          Colors.green.shade300;

      iconColor =
          Colors.green;

      bgColor =
          Colors.green.shade50;

    } else if (
        cardType ==
        GuideCardType.personalized) {

      borderColor =
          Colors.orange.shade300;

      iconColor =
          Colors.deepOrange;

      bgColor =
          Colors.orange.shade50;

    } else {

      borderColor =
          Colors.grey.shade300;

      iconColor =
          Colors.grey.shade700;

      bgColor =
          Colors.grey.shade100;
    }

    final String badgeText =
        locked
            ? 'Terkunci'
            : 'Terbuka';

    final Color badgeColor =
        locked
            ? Colors.grey.shade600
            : Colors.green;

    return InkWell(

      borderRadius:
          BorderRadius.circular(18),

      onTap: () =>
          _openGuide(item),

      child: Container(

        width: double.infinity,

        padding:
            const EdgeInsets.all(16),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(
            18,
          ),

          border: Border.all(
            color: borderColor,
            width: 1.2,
          ),

          boxShadow: [

            BoxShadow(
              color:
                  Colors.black.withValues(
                alpha: 0.04,
              ),

              blurRadius: 8,

              offset:
                  const Offset(
                0,
                3,
              ),
            ),
          ],
        ),

        child: Opacity(

          opacity:
              locked ? 0.85 : 1,

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // JUDUL + STATUS
              Row(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Expanded(

                    child: Text(

                      item.title,

                      style:
                          const TextStyle(

                        fontSize: 18,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  _statusBadge(
                    badgeText,
                    badgeColor,
                    locked,
                  ),
                ],
              ),

              const SizedBox(
                height: 8,
              ),

              // SUBTITLE + ICON
              Row(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Expanded(

                    child: Text(

                      item.subtitle,

                      style:
                          TextStyle(

                        color:
                            Colors.grey.shade700,

                        height: 1.4,
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Container(

                    padding:
                        const EdgeInsets.all(
                      12,
                    ),

                    decoration:
                        BoxDecoration(

                      color: bgColor,

                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),

                    child: Icon(

                      locked
                          ? Icons.lock_outline
                          : item.icon,

                      color:
                          iconColor,

                      size: 26,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 12,
              ),

              // LABEL
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: item.highlights.map(
                  (text) {

                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 8,
                      ),

                      child: Container(

                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),

                        decoration: BoxDecoration(

                          color: Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                            20,
                          ),

                          border: Border.all(
                            color:
                                Colors.grey.shade300,
                          ),
                        ),

                        child: Text(

                          text,

                          style: TextStyle(
                            color:
                                Colors.grey.shade700,

                            fontSize: 12,

                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String infoText) {
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            color: Color(0xFF2D9CDB),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Informasi Penting',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  infoText,
                  style: const TextStyle(
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
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.blue.shade100,
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
    Color textColor,
    bool locked,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: locked ? Colors.grey.shade100 : Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: locked ? Colors.grey.shade600 : textColor,
        ),
      ),
    );
  }
}