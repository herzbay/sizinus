import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/custom_bottom_navbar.dart';
import '../../widgets/custom_topbar.dart';
import '../../models/simulation/simulation_data.dart';
import '../../services/simulation/local_simulation_storage.dart';

class LeaderboardUser {
  final String name;
  final int points;
  final int level;
  final bool isCurrentUser;

  const LeaderboardUser({
    required this.name,
    required this.points,
    required this.level,
    this.isCurrentUser = false,
  });
}

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({
    super.key,
  });

  @override
  State<LeaderboardScreen> createState() =>
      _LeaderboardScreenState();
}

class _LeaderboardScreenState
    extends State<LeaderboardScreen> {
  final LocalSimulationStorage storage =
      LocalSimulationStorage();

  SimulationData? simulationData;

  bool isLoading = true;

  static const int _pointsPerLevel = 50;

  List<LeaderboardUser> leaderboard = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await storage.load();

    final myPoint = data?.totalXp ?? 0;

    final myLevel =
        (myPoint ~/ _pointsPerLevel) + 1;

    leaderboard = [
      const LeaderboardUser(
        name: 'Andi Saputra',
        points: 850,
        level: 18,
      ),
      const LeaderboardUser(
        name: 'Budi Santoso',
        points: 760,
        level: 16,
      ),
      const LeaderboardUser(
        name: 'Citra Lestari',
        points: 680,
        level: 14,
      ),
      const LeaderboardUser(
        name: 'Dewi Anggraini',
        points: 610,
        level: 13,
      ),
      const LeaderboardUser(
        name: 'Eko Prasetyo',
        points: 560,
        level: 12,
      ),
      LeaderboardUser(
        name: 'Anda',
        points: myPoint,
        level: myLevel,
        isCurrentUser: true,
      ),
      const LeaderboardUser(
        name: 'Farhan',
        points: 230,
        level: 5,
      ),
      const LeaderboardUser(
        name: 'Gilang',
        points: 180,
        level: 4,
      ),
      const LeaderboardUser(
        name: 'Hana',
        points: 140,
        level: 3,
      ),
      const LeaderboardUser(
        name: 'Indra',
        points: 90,
        level: 2,
      ),
    ];

    leaderboard.sort(
      (a, b) => b.points.compareTo(a.points),
    );

    if (!mounted) return;

    setState(() {
      simulationData = data;
      isLoading = false;
    });
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
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.reward,
        );
        break;

      case 3:
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
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: const CustomTopBar(),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
// =======================
// HEADER
// =======================

Container(
  width: double.infinity,
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.blue.shade50,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: Colors.blue.shade200,
    ),
  ),
  child: Column(
    crossAxisAlignment:
        CrossAxisAlignment.start,
    children: [

      const Row(
        children: [

          Icon(
            Icons.leaderboard_rounded,
            color: Color(0xFF2D9CDB),
            size: 30,
          ),

          SizedBox(width: 10),

          Text(
            'Leaderboard',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),

      const SizedBox(height: 12),

      Text(
        'Peringkat pengguna berdasarkan jumlah poin yang diperoleh dari penyelesaian simulasi, panduan usaha, dan misi.',
        style: TextStyle(
          color: Colors.grey.shade700,
          height: 1.5,
        ),
      ),
    ],
  ),
),

const SizedBox(height: 20),

// =======================
// TOP 3 PODIUM
// =======================

Row(
  crossAxisAlignment:
      CrossAxisAlignment.end,
  children: [

    Expanded(
      child: _buildPodium(
        rank: 2,
        user: leaderboard[1],
        height: 130,
        color: Colors.grey,
      ),
    ),

    const SizedBox(width: 10),

    Expanded(
      child: _buildPodium(
        rank: 1,
        user: leaderboard[0],
        height: 170,
        color: Colors.amber,
      ),
    ),

    const SizedBox(width: 10),

    Expanded(
      child: _buildPodium(
        rank: 3,
        user: leaderboard[2],
        height: 110,
        color: const Color(0xFFCD7F32),
      ),
    ),
  ],
),

const SizedBox(height: 25),

// =======================
// STATISTIK
// =======================

Container(
  padding: const EdgeInsets.all(18),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius:
        BorderRadius.circular(18),
    boxShadow: [

      BoxShadow(
        color: Colors.black.withValues(
          alpha: 0.05,
        ),
        blurRadius: 8,
        offset: const Offset(
          0,
          3,
        ),
      ),
    ],
  ),

  child: Row(
    mainAxisAlignment:
        MainAxisAlignment.spaceAround,

    children: [

      Column(
        children: [

          const Text(
            'Peserta',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            '${leaderboard.length}',
            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),

      Container(
        width: 1,
        height: 45,
        color: Colors.grey.shade300,
      ),

      Column(
        children: [

          const Text(
            'Poin Anda',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            '${simulationData?.totalXp ?? 0}',
            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),

      Container(
        width: 1,
        height: 45,
        color: Colors.grey.shade300,
      ),

      Column(
        children: [

          const Text(
            'Level',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            '${((simulationData?.totalXp ?? 0) ~/ 50) + 1}',
            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    ],
  ),
),

const SizedBox(height: 24),

const Text(
  'Daftar Peringkat',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 14),

ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: leaderboard.length,
  itemBuilder: (context, index) {
    return _buildRankingCard(
      rank: index + 1,
      user: leaderboard[index],
    );
  },
),

const SizedBox(height: 30),
],
),
),
),

bottomNavigationBar: CustomBottomNavbar(
  currentIndex: 3,
  onTap: _onBottomNavTap,
),
);
}

Widget _buildPodium({
  required int rank,
  required LeaderboardUser user,
  required double height,
  required Color color,
}) {
  return Column(
    children: [

      CircleAvatar(
        radius: 32,
        backgroundColor: color,
        child: Text(
          '$rank',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      const SizedBox(height: 10),

      Text(
        user.name,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 4),

      Text(
        '${user.points} poin',
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),

      const SizedBox(height: 10),

      Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.20),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(18),
          ),
        ),
      ),
    ],
  );
}

Widget _buildRankingCard({
  required int rank,
  required LeaderboardUser user,
}) {

  final bool isMe =
      user.isCurrentUser;

  return Container(
    margin: const EdgeInsets.only(
      bottom: 12,
    ),

    padding: const EdgeInsets.all(16),

    decoration: BoxDecoration(

      color: isMe
          ? Colors.blue.shade50
          : Colors.white,

      borderRadius:
          BorderRadius.circular(18),

      border: Border.all(
        color: isMe
            ? const Color(0xFF2D9CDB)
            : Colors.grey.shade200,
      ),

      boxShadow: [

        BoxShadow(
          color: Colors.black.withValues(
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

    child: Row(
      children: [

        CircleAvatar(
          radius: 18,

          backgroundColor:
              rank <= 3
                  ? Colors.amber
                  : Colors.grey.shade300,

          child: Text(
            '$rank',
            style: TextStyle(
              color: rank <= 3
                  ? Colors.white
                  : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Row(
                children: [

                  Expanded(
                    child: Text(
                      user.name,
                      style: const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  if (isMe)
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),

                      decoration: BoxDecoration(
                        color:
                            Colors.green.shade100,

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),
                      ),

                      child: const Text(
                        'Anda',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 6),

              Text(
                'Level ${user.level}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        Column(
          crossAxisAlignment:
              CrossAxisAlignment.end,

          children: [

            const Text(
              'Poin',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),

            Text(
              '${user.points}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
                color: Color(0xFF2D9CDB),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
}