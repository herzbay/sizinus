import 'package:flutter/material.dart';

import '../../widgets/custom_bottom_navbar.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({super.key});

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
                  radius: 25,
                  backgroundColor: Colors.white24,

                  child: const Icon(
                    Icons.flag_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 14),

                const Text(
                  'Misi',
                  style: TextStyle(
                    fontSize: 30,
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
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // XP CARD
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1877B9),
                    Color(0xFF008C55),
                  ],
                ),

                borderRadius: BorderRadius.circular(28),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Row(
                    children: [

                      Container(
                        padding: const EdgeInsets.all(16),

                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius:
                              BorderRadius.circular(18),
                        ),

                        child: const Icon(
                          Icons.local_fire_department,
                          color: Colors.orange,
                          size: 38,
                        ),
                      ),

                      const Spacer(),

                      const Text(
                        '1,850 XP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'Streak 7 Hari 🔥',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Level 1 - Learner',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Progress ke Level 2',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 10),

                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(20),

                    child: LinearProgressIndicator(
                      value: 0.75,
                      minHeight: 14,
                      backgroundColor: Colors.white24,
                      valueColor:
                          const AlwaysStoppedAnimation(
                        Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Align(
                    alignment: Alignment.centerRight,

                    child: Text(
                      '75%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // DAILY MISSION
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  'Misi Harian',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius:
                        BorderRadius.circular(18),
                  ),

                  child: const Text(
                    'Reset 12 Jam',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // MISSION LIST
            missionCard(
              icon: Icons.description,
              title: 'Lengkapi Simulasi NIB',
              subtitle:
                  'Selesaikan simulasi pembuatan NIB pertama.',
              progress: 0.8,
              xp: '+120 XP',
              completed: false,
              color: Colors.blue,
            ),

            missionCard(
              icon: Icons.upload_file,
              title: 'Upload Dokumen',
              subtitle:
                  'Unggah minimal 2 dokumen simulasi.',
              progress: 1.0,
              xp: '+80 XP',
              completed: true,
              color: Colors.green,
            ),

            missionCard(
              icon: Icons.verified,
              title: 'Verifikasi Profil',
              subtitle:
                  'Lengkapi informasi akun dan nomor telepon.',
              progress: 0.5,
              xp: '+50 XP',
              completed: false,
              color: Colors.orange,
            ),

            const SizedBox(height: 35),

            // WEEKLY CHALLENGE
            const Text(
              'Challenge Mingguan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF7B1FA2),
                    Color(0xFF512DA8),
                  ],
                ),

                borderRadius: BorderRadius.circular(26),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Row(
                    children: [

                      Container(
                        padding: const EdgeInsets.all(16),

                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius:
                              BorderRadius.circular(18),
                        ),

                        child: const Icon(
                          Icons.workspace_premium,
                          color: Colors.amber,
                          size: 38,
                        ),
                      ),

                      const Spacer(),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius:
                              BorderRadius.circular(18),
                        ),

                        child: const Text(
                          '3 Hari Lagi',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Master Simulasi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Selesaikan 5 simulasi izin usaha dalam 1 minggu.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 17,
                    ),
                  ),

                  const SizedBox(height: 22),

                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(20),

                    child: LinearProgressIndicator(
                      value: 0.6,
                      minHeight: 14,
                      backgroundColor: Colors.white24,
                      valueColor:
                          const AlwaysStoppedAnimation(
                        Colors.amber,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [

                      Text(
                        '3 / 5 Selesai',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),

                      Text(
                        '+500 XP',
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // COMPLETED MISSION
            const Text(
              'Misi Selesai',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            completedMission(
              title: 'Login 3 Hari Berturut-turut',
              xp: '+40 XP',
            ),

            completedMission(
              title: 'Selesaikan Tutorial Awal',
              xp: '+30 XP',
            ),

            completedMission(
              title: 'Lengkapi Profil Akun',
              xp: '+50 XP',
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),

      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }

  // MISSION CARD
  Widget missionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required double progress,
    required String xp,
    required bool completed,
    required Color color,
  }) {

    return Container(
      margin: const EdgeInsets.only(bottom: 18),

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        children: [

          Row(
            children: [

              Container(
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius:
                      BorderRadius.circular(16),
                ),

                child: Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          ClipRRect(
            borderRadius:
                BorderRadius.circular(20),

            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: Colors.grey.shade200,
              valueColor:
                  AlwaysStoppedAnimation(color),
            ),
          ),

          const SizedBox(height: 18),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              Text(
                xp,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              completed
                  ? Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                            BorderRadius.circular(18),
                      ),

                      child: const Text(
                        'Selesai',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {},

                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor: color,

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),
                        ),
                      ),

                      child: const Text(
                        'Kerjakan',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  // COMPLETED MISSION
  Widget completedMission({
    required String title,
    required String xp,
  }) {

    return Container(
      margin: const EdgeInsets.only(bottom: 16),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),

      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.12),

              borderRadius:
                  BorderRadius.circular(14),
            ),

            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Text(
            xp,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}