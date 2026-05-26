import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_bottom_navbar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF5F5F5),

      // APP BAR
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF2D9CDB),
                Color(0xFF27AE60),
              ],
            ),
          ),
          child: SafeArea(
            child: Row(
              children: [
                // Logo
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.business_center,
                    color: Color(0xFF2D9CDB),
                  ),
                ),

                const SizedBox(width: 12),

                const Text(
                  'SIZINUS',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const Spacer(),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.orange,
                    size: 30,
                  ),
                ),

                IconButton(
                  onPressed: () {

                    Navigator.pushNamed(
                      context,
                      AppRoutes.settings,
                    );
                  },

                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            // PROFILE CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2D9CDB),
                    Color(0xFF27AE60),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 26),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LEVEL
                  Row(
                    children: [
                      const Icon(
                        Icons.diamond,
                        color: Colors.pinkAccent,
                      ),

                      const SizedBox(width: 6),

                      const Text(
                        'Level 1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            '75',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                          Text(
                            '/ 100 XP',
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Bayu Herlambang',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Progres ke Level 2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '75%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: 0.75,
                      minHeight: 14,
                      backgroundColor: Colors.white38,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // BADGES
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      badgeItem(
                        icon: Icons.pets,
                        title: 'First Timer',
                        color: Colors.orange,
                      ),
                      badgeItem(
                        icon: Icons.star,
                        title: 'Learner',
                        color: Colors.orange,
                      ),
                      badgeItem(
                        icon: Icons.workspace_premium,
                        title: '',
                        color: Colors.amber,
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 22),

            // MENU
            dashboardMenu(
              title: 'Simulasi Perizinan',
              subtitle: 'Pahami setiap alur perizinan',
              xp: '+50 XP',
              icon: Icons.edit_document,
            ),

            dashboardMenu(
              title: 'Panduan UMKM',
              subtitle: 'Pelajari tips dan trik perizinan',
              xp: '+50 XP',
              icon: Icons.menu_book,
            ),

            dashboardMenu(
              title: 'Rekomendasi Izin',
              subtitle: 'Lihat izin yang direkomendasikan',
              xp: '+20 XP',
              icon: Icons.speed,
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }

  // BADGE ITEM
  Widget badgeItem({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          if (title.isNotEmpty) ...[
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ]
        ],
      ),
    );
  }

  // MENU CARD
  Widget dashboardMenu({
    required String title,
    required String subtitle,
    required String xp,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 20),
            blurRadius: 6,
            offset: const Offset(0, 4),
          )
        ],
      ),

      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 18),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '💡 $xp',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Icon(
            icon,
            size: 48,
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  // NAVIGATION ITEM
  Widget navItem(IconData icon, bool active) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: active
          ? const BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            )
          : null,
      child: Icon(
        icon,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}