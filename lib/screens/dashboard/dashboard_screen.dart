import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../providers/session_provider.dart';

import '../../routes/app_routes.dart';

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
    extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 11) {
      return 'Selamat Pagi ☀️';
    }

    if (hour >= 11 && hour < 15) {
      return 'Selamat Siang 🌤️';
    }

    if (hour >= 15 && hour < 18) {
      return 'Selamat Sore 🌇';
    }

    return 'Selamat Malam 🌙';
  }

  void onBottomTap(BuildContext context, int index) {
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

  late AnimationController _heroController;

  late Animation<double> _fadeAnimation;

  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _heroController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 550,
      ),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _heroController,
      curve: Curves.easeOut,
    );

    _slideAnimation =
        Tween<Offset>(
      begin: const Offset(
        0,
        0.12,
      ),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _heroController,
        curve: Curves.easeOutCubic,
      ),
    );

    _heroController.forward();
  }

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final session = context.watch<SessionProvider>();

    if (!session.isLoggedIn || session.simulationData == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
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
        onTap: (index) =>
            onBottomTap(context, index),
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

              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildHeroCard(session),
                ),
              ),

              const SizedBox(
                height: 22,
              ),

              dashboardMenu(
                title:
                    'Simulasi Perizinan',
                subtitle:
                    'Pahami setiap alur perizinan',
                xp:
                    '+250 Poin',
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

  Widget _buildHeroCard(SessionProvider session,) {
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

          Text(
            getGreeting(),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            session.currentUser!.fullName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(
                alpha: 0.08,
              ),

              border: Border.all(
                color: Colors.white24,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              children: [

                _buildHeroStat(
                  image: 'assets/images/icon_level.png',
                  value: 'Lv.${session.currentLevel}',
                ),

                Container(
                  width: 1,
                  height: 26,
                  color: Colors.white24,
                ),

                _buildHeroStat(
                  image: 'assets/images/icon_xp.png',
                  value: '${session.totalPoint} XP',
                ),

                Container(
                  width: 1,
                  height: 26,
                  color: Colors.white24,
                ),

                _buildHeroStat(
                  image: 'assets/images/icon_lencana.png',
                  value: '${session.badgeCount}',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
            children: [

              Text(
                'Progres ke Level ${session.currentLevel + 1}',
                style:
                    const TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),

              Text(
                '${(session.progress * 100).round()}%',
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
              value: session.progress,
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

          session.latestBadges.isEmpty

              ? Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: 0.08,
                    ),

                    border: Border.all(
                      color: Colors.white24,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      'Belum ada lencana yang diperoleh.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                )

              : Row(
                  children: List.generate(
                    session.latestBadges.length,
                    (index) {
                      final badge =
                          session.latestBadges[index];

                      return Expanded(
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.only(
                            right: index ==
                                    session.latestBadges.length - 1
                                ? 0
                                : 10,
                          ),
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(
                              alpha: 0.08,
                            ),

                            border: Border.all(
                              color: Colors.white24,
                            ),
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.center,
                            children: [

                              Image.asset(
                                badge.imageAsset,
                                width: 38,
                                height: 38,
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  badge.title,
                                  maxLines: 2,
                                  overflow:
                                      TextOverflow.ellipsis,
                                  style:
                                      const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight:
                                        FontWeight.w600,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildHeroStat({
    required String image,
    required String value,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        Image.asset(
          image,
          width: 22,
          height: 22,
          fit: BoxFit.contain,
        ),

        const SizedBox(width: 6),

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Image.asset(
                          'assets/images/icon_xp.png',
                          width: 16,
                          height: 16,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          xp,
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
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