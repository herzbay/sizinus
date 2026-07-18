import 'package:flutter/material.dart';

import '../../../models/simulation/simulation_data.dart';
import '../../../services/simulation/local_simulation_storage.dart';

class NibRewardScreen extends StatefulWidget {
  const NibRewardScreen({
    super.key,
  });

  @override
  State<NibRewardScreen> createState() =>
      _NibRewardScreenState();
}

class _NibRewardScreenState
    extends State<NibRewardScreen> {

  final LocalSimulationStorage storage =
      LocalSimulationStorage();

  SimulationData? simulationData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSimulation();
  }

  Future<void> _loadSimulation() async {
    final data = await storage.load();

    if (!mounted) return;

    setState(() {
      simulationData = data;
      isLoading = false;
    });
  }

  void _goToDashboard() {
    Navigator.popUntil(
      context,
      (route) => route.isFirst,
    );
  }

  String get _badgeTitle {
    final count =
        simulationData?.nibCompletedCount ?? 1;

    if (count <= 1) {
      return '+1 Lencana';
    }

    return 'Lencana NIB x$count';
  }

  String get _badgeDescription {
    final count =
        simulationData?.nibCompletedCount ?? 1;

    if (count <= 1) {
      return 'Menyelesaikan simulasi pembuatan NIB';
    }

    return 'Menyelesaikan simulasi NIB sebanyak $count kali';
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


    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              18,
              18,
              28,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // HERO
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius:
                        BorderRadius.circular(22),
                    border: Border.all(
                      color: Colors.blue.shade200,
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/icon_hadiah.png',
                        height: 130,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Simulasi Selesai',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Anda berhasil menyelesaikan seluruh langkah simulasi penerbitan NIB',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // XP + BADGE
                Row(
                  children: [
                    Expanded(
                      child: _rewardCard(
                        backgroundColor:
                            const Color(0xFFEAF7EE),
                        borderColor:
                            Colors.green.shade200,
                        iconPath:
                            'assets/images/icon_xp.png',
                        title: '+200 Poin',
                        subtitle:
                            'Poin penyelesaian simulasi',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _rewardCard(
                        backgroundColor:
                            const Color(0xFFFFF8E1),
                        borderColor:
                            Colors.amber.shade200,
                        iconPath:
                            'assets/images/icon_lencana.png',
                        title: _badgeTitle,
                        subtitle: _badgeDescription,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // LANGKAH BERIKUTNYA
                _sectionCard(
                  title: 'Langkah Selanjutnya',
                  icon: Icons.auto_awesome_outlined,
                  iconColor: Colors.orange,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: const [
                      Text('• Melihat rekomendasi izin usaha'),
                      SizedBox(height: 6),
                      Text('• Mempelajari panduan perizinan usaha'),
                      SizedBox(height: 6),
                      Text('• Mengulang simulasi jika diperlukan'),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _goToDashboard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF2D9CDB),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Kembali ke Beranda',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _rewardCard({
    required Color backgroundColor,
    required Color borderColor,
    required String iconPath,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Image.asset(
            iconPath,
            width: 42,
            height: 42,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.blue.shade100,
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
              Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}