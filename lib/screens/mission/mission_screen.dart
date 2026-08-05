import 'package:flutter/material.dart';

import '../../models/mission/mission_item.dart';
import 'package:provider/provider.dart';
import '../../providers/session_provider.dart';
import '../../providers/simulation_provider.dart';

import '../../routes/app_routes.dart';

import '../../widgets/custom_bottom_navbar.dart';
import '../../widgets/custom_topbar.dart';
import '../../models/mission/mission_status.dart';
import '../../services/mission/mission_engine.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({super.key});

  int completedMissionCount(
    SimulationProvider provider,
  ) {
    final missions =
        MissionEngine.generate(
      provider.simulation,
    );

    return missions
        .where(
          (m) =>
              m.status ==
              MissionStatus.claimed,
        )
        .length;
  }

  double progress(
    SimulationProvider provider,
  ) {
    final list =
        MissionEngine.generate(
      provider.simulation,
    );

    if (list.isEmpty) {
      return 0;
    }

    return completedMissionCount(
          provider,
        ) /
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

    final sessionProvider =
        context.watch<SessionProvider>();

    final simulationProvider =
        context.watch<SimulationProvider>();

    if (!sessionProvider.isLoggedIn ||
        simulationProvider.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final missionList =
        MissionEngine.generate(
          simulationProvider.simulation,
        );

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
              (mission) =>
                  buildMissionCard(
                    context,
                    simulationProvider,
                    mission,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMissionCard(
    BuildContext context,
    SimulationProvider provider,
    MissionItem mission,
  ) {
    final status = mission.status;

    Color borderColor;

    IconData icon;

    switch (status) {
      case MissionStatus.claimable:
        borderColor = Colors.orange;
        icon = Icons.card_giftcard;
        break;

      case MissionStatus.claimed:
        borderColor = Colors.green;
        icon = Icons.check_circle;
        break;

      case MissionStatus.incomplete:
        borderColor = Colors.grey.shade300;
        icon = Icons.radio_button_unchecked;
        break;
    }

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),
      padding:
          const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        children: [

          Row(
            children: [

              Icon(
                icon,
                color: borderColor,
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

          if (status ==
              MissionStatus.claimable) ...[

            const SizedBox(
              height: 14,
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.card_giftcard,
                ),
                label: Text(
                  'Klaim +${mission.rewardPoint} XP',
                ),
                onPressed: () async {

                  final success =
                      await provider
                          .claimMission(
                    mission,
                  );

                  if (!context.mounted) {
                    return;
                  }

                  if (success) {

                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text(
                            '🎉 Selamat Misi Berhasil!',
                          ),
                          content:
                              Text(
                            'Anda mendapatkan +${mission.rewardPoint} Poin',
                          ),
                          actions: [

                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                );
                              },
                              child:
                                  const Text(
                                'OK',
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}