import 'package:flutter/material.dart';

import '../../data/reward/badge_repository.dart';
import '../../models/auth/user_model.dart';
import '../../models/reward/badge.dart';
import '../../models/simulation/simulation_data.dart';

import '../../routes/app_routes.dart';

import '../../services/auth/local_auth_service.dart';
import '../../services/simulation/local_simulation_storage.dart';

import '../../widgets/custom_bottom_navbar.dart';
import '../../widgets/custom_topbar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

  final LocalAuthService auth =
      LocalAuthService();

  final LocalSimulationStorage storage =
      LocalSimulationStorage();

  UserModel? user;

  SimulationData? simulation;

  bool isLoading = true;

  static const int pointsPerLevel = 50;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {

    final currentUser =
        await auth.getCurrentUser();

    final simulationData =
        await storage.load();

    if (!mounted) return;

    setState(() {

      user = currentUser;

      simulation = simulationData;

      isLoading = false;

    });
  }

  int get totalPoint =>
      simulation?.totalXp ?? 0;

  int get currentLevel =>
      (totalPoint ~/ pointsPerLevel) + 1;

  double get progress {

    final current =
        totalPoint % pointsPerLevel;

    return current /
        pointsPerLevel;
  }

  List<RewardBadge> get latestBadges {

    final ids =
        simulation?.unlockedBadges ?? [];

    if (ids.isEmpty) {
      return [];
    }

    return BadgeRepository
        .allBadges
        .where(
          (badge) =>
              ids.contains(
            badge.id,
          ),
        )
        .take(2)
        .toList();
  }

  void onBottomTap(int index) {

    switch (index) {

      case 1:

        Navigator.pushReplacementNamed(
          context,
          AppRoutes.mission,
        );

        break;

      case 2:

        Navigator.pushReplacementNamed(
          context,
          AppRoutes.reward,
        );

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

  @override
  Widget build(BuildContext context) {

    if (isLoading) {

      return const Scaffold(

        body: Center(

          child:
              CircularProgressIndicator(),

        ),

      );
    }

    return Scaffold(

      backgroundColor:
          const Color(
        0xFFF5F5F5,
      ),

      appBar: const CustomTopBar(),

      bottomNavigationBar:
          CustomBottomNavbar(
        currentIndex: 0,
        onTap: onBottomTap,
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding:
              const EdgeInsets.fromLTRB(
            18,
            18,
            18,
            24,
          ),

          child: Column(

            children: [

              _buildHeroCard(),

              const SizedBox(
                height: 22,
              ),

              dashboardMenu(
                title:
                    'Simulasi Perizinan',
                subtitle:
                    'Pahami setiap alur perizinan',
                xp:
                    '+200 Poin',
                icon:
                    Icons.edit_document,
                onTap: () {

                  Navigator.pushNamed(
                    context,
                    AppRoutes
                        .simulationList,
                  );

                },
              ),

              dashboardMenu(
                title:
                    'Rekomendasi Perizinan',
                subtitle:
                    'Lihat izin yang disarankan',
                xp:
                    '+100 Poin',
                icon: Icons
                    .fact_check_outlined,
                onTap: () {

                  Navigator.pushNamed(
                    context,
                    AppRoutes
                        .permitRecommendation,
                  );

                },
              ),

              dashboardMenu(
                title:
                    'Panduan Usaha',
                subtitle:
                    'Pelajari langkah usaha',
                xp:
                    '+50 Poin',
                icon:
                    Icons.menu_book,
                onTap: () {

                  Navigator.pushNamed(
                    context,
                    AppRoutes
                        .businessGuide,
                  );

                },
              ),

              const SizedBox(
                height: 100,
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2D9CDB),
            Color(0xFF27AE60),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.10,
            ),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          const Text(
            'Halo,',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            user?.fullName ??
                'Pengguna',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [

              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),
                  child: Column(
                    children: [

                      const Icon(
                        Icons.workspace_premium,
                        color: Colors.amber,
                        size: 30,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Level $currentLevel',
                        style:
                            const TextStyle(
                          color: Colors.white,
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),
                  child: Column(
                    children: [

                      const Icon(
                        Icons.bolt,
                        color: Colors.yellow,
                        size: 30,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        '$totalPoint Poin',
                        style:
                            const TextStyle(
                          color: Colors.white,
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
            children: [

              Text(
                'Progres ke Level ${currentLevel + 1}',
                style:
                    const TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),

              Text(
                '${(progress * 100).round()}%',
                style:
                    const TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius:
                BorderRadius.circular(20),
            child:
                LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor:
                  Colors.white24,
              valueColor:
                  const AlwaysStoppedAnimation(
                Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Badge Terbaru',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          latestBadges.isEmpty

              ? Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius:
                        BorderRadius.circular(
                      16,
                    ),
                  ),
                  child: const Text(
                    'Belum ada badge yang diperoleh.',
                    textAlign:
                        TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )

              : Row(
                  children: latestBadges
                      .map(
                        (badge) => Expanded(
                          child: Container(
                            margin:
                                const EdgeInsets.only(
                              right: 10,
                            ),
                            padding:
                                const EdgeInsets
                                    .all(14),
                            decoration:
                                BoxDecoration(
                              color:
                                  Colors.white12,
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                16,
                              ),
                            ),
                            child: Column(
                              children: [

                                Image.asset(
                                  badge.imageAsset,
                                  height: 56,
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                Text(
                                  badge.title,
                                  textAlign:
                                      TextAlign
                                          .center,
                                  maxLines: 2,
                                  overflow:
                                      TextOverflow
                                          .ellipsis,
                                  style:
                                      const TextStyle(
                                    color:
                                        Colors
                                            .white,
                                    fontSize:
                                        12,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
        ],
      ),
    );
  }

    Widget dashboardMenu({
    required String title,
    required String subtitle,
    required String xp,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 18,
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.05,
              ),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [

            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: const Color(
                  0xFF2D9CDB,
                ).withValues(alpha: 0.10),
                borderRadius:
                    BorderRadius.circular(18),
              ),
              child: Icon(
                icon,
                size: 30,
                color: const Color(
                  0xFF2D9CDB,
                ),
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style:
                        const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    subtitle,
                    style:
                        TextStyle(
                      color:
                          Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Text(
                      xp,
                      style:
                          TextStyle(
                        color:
                            Colors.green.shade700,
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}