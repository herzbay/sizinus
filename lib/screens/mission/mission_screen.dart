import 'package:flutter/material.dart';

import '../../models/mission/mission_item.dart';
import '../../models/simulation/simulation_data.dart';

import '../../routes/app_routes.dart';

import '../../services/simulation/local_simulation_storage.dart';

import '../../widgets/custom_bottom_navbar.dart';
import '../../widgets/custom_topbar.dart';

class MissionScreen extends StatefulWidget {
  const MissionScreen({super.key});

  @override
  State<MissionScreen> createState() =>
      _MissionScreenState();
}

class _MissionScreenState
    extends State<MissionScreen> {

  final storage =
      LocalSimulationStorage();

  SimulationData? simulationData;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {

    final data =
        await storage.load();

    setState(() {

      simulationData = data;
      isLoading = false;
    });
  }

  List<MissionItem> get missions {

    final data =
        simulationData ??
            SimulationData();

    return [

      // UTAMA

      MissionItem(
        title:
            'Selesaikan Simulasi NIB',

        description:
            'Pelajari proses penerbitan NIB.',

        completed:
            data.nibCompleted,
      ),

      MissionItem(
        title:
            'Buka Rekomendasi Perizinan',

        description:
            'Lihat hasil rekomendasi izin usaha.',

        completed:
            data.recommendationRewardClaimed,
      ),

      MissionItem(
        title:
            'Dapatkan Lencana Pertama',

        description:
            'Buka satu lencana apa pun.',

        completed:
            data.unlockedBadges.isNotEmpty,
      ),

      // BELAJAR

      MissionItem(
        title:
            'Selesaikan Panduan NIB',

        description:
            'Baca dan simpan panduan NIB.',

        completed:
            data.completedGuideIds.contains(
              'guide_nib',
            ),
      ),

      MissionItem(
        title:
            'Selesaikan Panduan Halal',

        description:
            'Baca dan simpan panduan halal.',

        completed:
            data.completedGuideIds.contains(
              'guide_halal',
            ),
      ),

      MissionItem(
        title:
            'Selesaikan Panduan PIRT',

        description:
            'Baca dan simpan panduan PIRT.',

        completed:
            data.completedGuideIds.contains(
              'guide_pirt',
            ),
      ),

      // KOLEKTOR

      MissionItem(
        title:
            'Kumpulkan 3 Lencana',

        description:
            'Miliki minimal 3 lencana.',

        completed:
            data.unlockedBadges.length >= 3,
      ),

      MissionItem(
        title:
            'Kumpulkan 5 Lencana',

        description:
            'Miliki minimal 5 lencana.',

        completed:
            data.unlockedBadges.length >= 5,
      ),
    ];
  }

  int get completedMissionCount {

    return missions
        .where(
          (m) => m.completed,
        )
        .length;
  }

  double get progress {

    if (missions.isEmpty) {
      return 0;
    }

    return completedMissionCount /
        missions.length;
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
  Widget build(
    BuildContext context,
  ) {

    if (isLoading) {

      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(

      appBar:
          const CustomTopBar(),

      bottomNavigationBar:
          CustomBottomNavbar(
        currentIndex: 1,
        onTap: _onBottomNavTap,
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(
          18,
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Container(

              padding:
                  const EdgeInsets.all(
                18,
              ),

              decoration:
                  BoxDecoration(

                color:
                    Colors.blue.shade50,

                borderRadius:
                    BorderRadius.circular(
                  20,
                ),

                border: Border.all(
                  color:
                      Colors.blue.shade200,
                ),
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(

                    'Progress Misi',

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Text(
                    '$completedMissionCount / ${missions.length} Misi Selesai',
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            const Text(

              'Daftar Misi',

              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 14,
            ),

            ...missions.map(
              buildMissionCard,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMissionCard(
    MissionItem mission,
  ) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),

      padding:
          const EdgeInsets.all(16),

      decoration:
          BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          18,
        ),

        border: Border.all(

          color: mission.completed
              ? Colors.green.shade300
              : Colors.grey.shade300,
        ),
      ),

      child: Row(

        children: [

          Icon(

            mission.completed
                ? Icons.check_circle
                : Icons.radio_button_unchecked,

            color: mission.completed
                ? Colors.green
                : Colors.grey,
          ),

          const SizedBox(
            width: 14,
          ),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  mission.title,

                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(
                  mission.description,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}