import 'package:flutter/material.dart';

import '../../widgets/custom_bottom_navbar.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // APPBAR
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),

        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0F6DA1),
                Color(0xFF007A3D),
              ],
            ),
          ),

          child: SafeArea(
            child: Row(
              children: [

                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white24,

                  child: const Icon(
                    Icons.shield,
                    color: Colors.white,
                    size: 32,
                  ),
                ),

                const SizedBox(width: 14),

                const Text(
                  'SIZINUS',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const Spacer(),

                IconButton(
                  onPressed: () {},

                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 30,
                  ),
                ),

                IconButton(
                  onPressed: () {},

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

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            18,
            18,
            18,
            24,
          ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // PROFILE LEVEL CARD
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1877B9),
                    Color(0xFF008C55),
                  ],
                ),

                borderRadius: BorderRadius.circular(24),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Row(
                    children: [

                      Container(
                        padding: const EdgeInsets.all(14),

                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius:
                              BorderRadius.circular(16),
                        ),

                        child: const Icon(
                          Icons.workspace_premium,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),

                      const Spacer(),

                      const Text(
                        '75 / 100 XP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Level 1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Bayu Herlambang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Progres ke Level 2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Stack(
                    children: [

                      Container(
                        height: 16,

                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                      ),

                      FractionallySizedBox(
                        widthFactor: 0.75,

                        child: Container(
                          height: 16,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Align(
                    alignment: Alignment.centerRight,

                    child: Text(
                      '75%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // BADGE HEADER
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  'Badge Koleksi',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextButton(
                  onPressed: () {},

                  child: const Text(
                    'Lihat Semua',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // BIG BADGE
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(22),

                border: Border.all(
                  color: Colors.green,
                  width: 1.5,
                ),
              ),

              child: Row(
                children: [

                  CircleAvatar(
                    radius: 42,
                    backgroundColor:
                        Colors.greenAccent.shade100,

                    child: const Icon(
                      Icons.workspace_premium,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),

                  const SizedBox(width: 20),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          'First Timer',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          'Selesaikan pendaftaran UMKM pertama Anda.',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // SMALL BADGES
            Row(
              children: [

                Expanded(
                  child: smallBadge(
                    title: 'Learner',
                    icon: Icons.star,
                    color: Colors.orange,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: smallBadge(
                    title: 'Verified',
                    icon: Icons.verified,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // LEADERBOARD
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  'Papan Peringkat',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),

                  child: const Text(
                    'Mingguan',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            leaderboardItem(
              rank: '1',
              name: 'Joko Susanto',
              level: 'Level 5 • Master UMKM',
              xp: '2,450 XP',
              highlight: false,
            ),

            leaderboardItem(
              rank: '2',
              name: 'Anisa Setyo',
              level: 'Level 4 • Pro',
              xp: '2,120 XP',
              highlight: false,
            ),

            leaderboardItem(
              rank: '4',
              name: 'Bayu Herlambang (Anda)',
              level: 'Level 1 • Learner',
              xp: '1,850 XP',
              highlight: true,
            ),

            leaderboardItem(
              rank: '5',
              name: 'Rudi Malik',
              level: 'Level 1',
              xp: '1,600 XP',
              highlight: false,
            ),

            leaderboardItem(
              rank: '6',
              name: 'Siska Kartika',
              level: 'Level 1',
              xp: '1,480 XP',
              highlight: false,
            ),

            const SizedBox(height: 120),
          ],
        ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: 2,
        onTap: (index) {},
      ),
    );
  }

  // SMALL BADGE
  Widget smallBadge({
    required String title,
    required IconData icon,
    required Color color,
  }) {

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 28,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        children: [

          CircleAvatar(
            radius: 34,
            backgroundColor: color.withValues(alpha: 0.15),

            child: Icon(
              icon,
              color: color,
              size: 34,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // LEADERBOARD ITEM
  Widget leaderboardItem({
    required String rank,
    required String name,
    required String level,
    required String xp,
    required bool highlight,
  }) {

    return Container(
      margin: const EdgeInsets.only(bottom: 16),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: highlight
            ? const Color(0xFF0B6EA8)
            : Colors.white,

        borderRadius: BorderRadius.circular(22),

        border: highlight
            ? Border.all(
                color: Colors.white,
                width: 2,
              )
            : null,
      ),

      child: Row(
        children: [

          SizedBox(
            width: 28,

            child: Text(
              rank,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: highlight
                    ? Colors.white
                    : Colors.black54,
              ),
            ),
          ),

          const SizedBox(width: 16),

          CircleAvatar(
            radius: 28,

            backgroundColor: highlight
                ? Colors.white24
                : Colors.grey.shade200,

            child: Text(
              name.substring(0, 2).toUpperCase(),

              style: TextStyle(
                color: highlight
                    ? Colors.white
                    : Colors.black54,

                fontWeight: FontWeight.bold,
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
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: highlight
                        ? Colors.white
                        : Colors.black,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  level,
                  style: TextStyle(
                    fontSize: 15,
                    color: highlight
                        ? Colors.white70
                        : Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          Text(
            xp,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: highlight
                  ? Colors.white
                  : Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}