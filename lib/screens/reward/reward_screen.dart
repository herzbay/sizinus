import 'package:flutter/material.dart';

import '../../data/reward/badge_repository.dart';
import '../../models/reward/badge.dart';
import '../../models/simulation/simulation_data.dart';
import '../../routes/app_routes.dart';
import '../../services/simulation/local_simulation_storage.dart';
import '../../widgets/custom_bottom_navbar.dart';
import '../../widgets/custom_topbar.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  final LocalSimulationStorage storage = LocalSimulationStorage();

  SimulationData? simulationData;
  bool isLoading = true;

  static const int _pointsPerLevel = 50;

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

  int get _totalPoints => simulationData?.totalXp ?? 0;

  bool get _isSimulationCompleted =>
      simulationData?.nibCompleted ?? false;

  int get _currentLevel {
    return (_totalPoints ~/ _pointsPerLevel) + 1;
  }

  int get _currentLevelStart {
    return (_currentLevel - 1) * _pointsPerLevel;
  }

  int get _nextLevelStart {
    return _currentLevel * _pointsPerLevel;
  }

  double get _progressToNextLevel {
    final progress =
        (_totalPoints - _currentLevelStart) / _pointsPerLevel;
    return progress.clamp(0.0, 1.0);
  }

  String get _nextLevelLabel {
    final remaining = _nextLevelStart - _totalPoints;
    return '$remaining poin menuju level ${_currentLevel + 1}';
  }

  void _onBottomNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.dashboard,
        );
        break;

      case 1:
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.mission,
        );
        break;

      case 2:
        break;

      case 3:
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.leaderboard,
        );
        break;

      case 4:
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.history,
        );
        break;
    }
  }

  void _showBadgeDetail(
    RewardBadge badge,
    bool earned,
  ) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: earned
                      ? Colors.green.shade50
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: earned
                        ? Colors.green.shade200
                        : Colors.grey.shade300,
                  ),
                ),
                child: _buildBadgeImage(
                  earned ? badge.imageAsset : 'assets/images/badge_rahasia.png',
                  height: 92,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                badge.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                badge.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: earned
                      ? Colors.green.shade50
                      : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: earned
                        ? Colors.green.shade200
                        : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  earned
                      ? 'Lencana ini sudah Anda dapatkan.'
                      : 'Lencana ini masih terkunci.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: earned ? Colors.green : Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D9CDB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Tutup',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
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

    final data = simulationData ?? SimulationData();
    final allBadges = BadgeRepository.allBadges;
    final ownedBadgeIds = data.unlockedBadges.toSet();

    return Scaffold(
      appBar: const CustomTopBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),

              const SizedBox(height: 16),

              _buildPointsCard(),

              const SizedBox(height: 20),

              _buildBadgeSectionHeader(),

              const SizedBox(height: 12),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allBadges.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final badge = allBadges[index];
                  final earned = ownedBadgeIds.contains(badge.id);

                  return _buildBadgeCard(
                    badge,
                    earned: earned,
                  );
                },
              ),

              const SizedBox(height: 18),

              _buildInfoCard(),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: 2,
        onTap: _onBottomNavTap,
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hadiah & Pencapaian',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _isSimulationCompleted
                      ? 'Anda sudah menyelesaikan simulasi. Lihat seluruh pencapaian dan lencana yang berhasil dibuka.'
                      : 'Kumpulkan poin dan lencana dari simulasi serta panduan yang sudah diselesaikan.',
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

  Widget _buildPointsCard() {
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
            color: Colors.black.withValues(alpha: 0.04),
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
                Icons.bolt_outlined,
                color: Colors.amber,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Poin Anda',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$_totalPoints',
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  'Poin',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Level $_currentLevel',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _nextLevelLabel,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: _progressToNextLevel,
              minHeight: 8,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFF2D9CDB),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(_progressToNextLevel * 100).round()}%',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Koleksi Lencana',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${simulationData?.unlockedBadges.length ?? 0}/${BadgeRepository.allBadges.length}',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBadgeCard(
    RewardBadge badge, {
    required bool earned,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),

      onTap: () => _showBadgeDetail(
        badge,
        earned,
      ),

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(18),

          border: Border.all(
            color: earned
                ? badge.color.withValues(
                    alpha: 0.25,
                  )
                : Colors.grey.shade300,
          ),

          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withValues(
                alpha: 0.04,
              ),

              blurRadius: 8,

              offset: const Offset(
                0,
                3,
              ),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Container(
              width: 72,
              height: 72,

              padding:
                  const EdgeInsets.all(8),

              decoration: BoxDecoration(
                color: earned
                    ? badge.color
                        .withValues(
                        alpha: 0.08,
                      )
                    : Colors.grey.shade100,

                borderRadius:
                    BorderRadius.circular(
                  18,
                ),
              ),

              child: _buildBadgeImage(
                earned
                    ? badge.imageAsset
                    : 'assets/images/badge_rahasia.png',
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),

              decoration: BoxDecoration(
                color: earned
                    ? Colors.green.shade50
                    : Colors.grey.shade100,

                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
              ),

              child: Text(
                earned
                    ? 'Didapat'
                    : 'Terkunci',

                style: TextStyle(
                  color: earned
                      ? Colors.green
                      : Colors.grey.shade600,

                  fontSize: 11,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              badge.title,

              textAlign:
                  TextAlign.center,

              maxLines: 2,

              overflow:
                  TextOverflow.ellipsis,

              style: const TextStyle(
                fontSize: 14,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeImage(String assetPath, {double height = 72}) {
    return Image.asset(
      assetPath,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            Icons.emoji_events_outlined,
            size: height * 0.45,
            color: Colors.grey.shade500,
          ),
        );
      },
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
        children: [

          Icon(
            Icons.touch_app_outlined,
            color: Color(0xFF2D9CDB),
          ),

          SizedBox(width: 12),

          Expanded(
            child: Text(

              'Ketuk lencana untuk melihat detail.',

              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}