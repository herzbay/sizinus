import 'package:flutter/material.dart';

import '../../models/mission/mission_item.dart';
import 'package:provider/provider.dart';
import '../../providers/session_provider.dart';
import '../../providers/simulation_provider.dart';

import '../../routes/app_routes.dart';

import '../../widgets/custom_bottom_navbar.dart';
import '../../widgets/custom_topbar.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({super.key});

  List<MissionItem> missions(
    SimulationProvider provider,
  ) {
    final data = provider.simulation;

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

  int completedMissionCount(
    SimulationProvider provider,
  ) {
    return missions(provider)
        .where((m) => m.completed)
        .length;
  }

  double progress(
    SimulationProvider provider,
  ) {
    final list = missions(provider);

    if (list.isEmpty) {
      return 0;
    }

    return completedMissionCount(provider) /
        list.length;
  }

  void _onBottomNavTap(BuildContext context, int index) {
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
  Widget build(BuildContext context,) {

    final session =
        context.watch<SessionProvider>();

    final simulationProvider =
        context.watch<SimulationProvider>();

    if (!session.isLoggedIn ||
        simulationProvider.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final missionList =
        missions(simulationProvider);

    return Scaffold(
      appBar:
          const CustomTopBar(),

      bottomNavigationBar:
          CustomBottomNavbar(
        currentIndex: 1,
        onTap: (index) => _onBottomNavTap(
          context,
          index,
        ),
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
                    '${completedMissionCount(simulationProvider)} / ${missionList.length} Misi Selesai',
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  LinearProgressIndicator(
                    value: progress(simulationProvider),
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

            ...missionList.map(
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