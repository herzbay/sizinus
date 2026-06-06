import 'package:flutter/material.dart';

import '../../widgets/custom_topbar.dart';
import '../../routes/app_routes.dart';
import '../../services/simulation/local_simulation_storage.dart';
import '../../models/simulation/simulation_data.dart';

class SimulationListScreen extends StatefulWidget {
  const SimulationListScreen({
    super.key,
  });

  @override
  State<SimulationListScreen> createState() =>
      _SimulationListScreenState();
}

class _SimulationListScreenState
    extends State<SimulationListScreen> {

  final LocalSimulationStorage storage =
      LocalSimulationStorage();

  SimulationData? simulationData;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {

    final data =
        await storage.load();

    if (!mounted) return;

    setState(() {

      simulationData = data;

      isLoading = false;
    });
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

    final bool isCompleted =
        simulationData?.nibCompleted ?? false;

    final int currentStep =
        isCompleted
            ? 7
            : ((simulationData?.unlockedStep ?? 1) - 1)
                .clamp(0, 7);

    const int totalStep = 7;

    final double progress =
        isCompleted
            ? 1.0
            : currentStep / totalStep;

    return Scaffold(

      appBar: const CustomTopBar(
        showBackButton: true,
      ),

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.all(18),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(
                'Simulasi Perizinan',

                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Pelajari proses perizinan usaha melalui simulasi interaktif.',

                style: TextStyle(
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 24),

              // CARD NIB
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    24,
                  ),

                  border: Border.all(
                    color: const Color(
                      0xFF2D9CDB,
                    ),
                    width: 1.2,
                  ),

                  boxShadow: [

                    BoxShadow(
                      color:
                          Colors.black.withValues(
                        alpha: 0.06,
                      ),

                      blurRadius: 10,

                      offset:
                          const Offset(
                        0,
                        4,
                      ),
                    ),
                  ],
                ),

                child: Padding(

                  padding:
                      const EdgeInsets.all(
                    20,
                  ),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      // HEADER
                      Row(

                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Expanded(

                            child: Column(

                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                const Text(
                                  'Nomor Induk Berusaha (NIB)',

                                  style: TextStyle(
                                    color:
                                        Color(
                                      0xFF1565C0,
                                    ),

                                    fontSize: 22,

                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                const Text(

                                  'Simulasi pembuatan NIB berdasarkan alur OSS Indonesia.',

                                  style: TextStyle(
                                    fontSize: 14,

                                    color:
                                        Colors.black87,

                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            width: 12,
                          ),

                          Container(

                            width: 72,
                            height: 72,

                            padding:
                                const EdgeInsets.all(
                              6,
                            ),

                            decoration:
                                BoxDecoration(

                              color:
                                  Colors.blue.shade50,

                              borderRadius:
                                  BorderRadius.circular(
                                18,
                              ),
                            ),

                            child: ClipRRect(

                              borderRadius:
                                  BorderRadius.circular(
                                14,
                              ),

                              child: Image.asset(
                                'assets/images/icon_nib.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      // PROGRESS
                      const Text(

                        'Progress Simulasi',

                        style: TextStyle(
                          fontSize: 13,

                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      ClipRRect(

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),

                        child:
                            LinearProgressIndicator(

                          value:
                              progress,

                          minHeight: 8,

                          backgroundColor:
                              const Color(
                            0xFFE5E7EB,
                          ),

                          valueColor:
                              AlwaysStoppedAnimation(
                            isCompleted
                                ? Colors.green
                                : const Color(
                                    0xFF2D9CDB,
                                  ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 6,
                      ),

                      Align(

                        alignment:
                            Alignment.centerRight,

                        child: Text(

                          isCompleted
                              ? '✓ Selesai'
                              : '$currentStep / $totalStep Langkah',

                          style:
                              const TextStyle(
                            fontSize: 12,

                            color:
                                Colors.black54,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      // XP
                      Container(

                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),

                        decoration: BoxDecoration(

                          color:
                              const Color(
                            0xFFEAF7EE,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            20,
                          ),
                        ),

                        child: Row(

                          mainAxisSize:
                              MainAxisSize.min,

                          children: [

                            Image.asset(
                              'assets/images/icon_xp.png',

                              width: 22,
                              height: 22,
                            ),

                            const SizedBox(
                              width: 8,
                            ),

                            const Text(

                              '+200 Poin',

                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // BADGE
                      Container(

                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),

                        decoration: BoxDecoration(

                          color:
                              const Color(
                            0xFFFFF8E1,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            20,
                          ),
                        ),

                        child: Row(

                          mainAxisSize:
                              MainAxisSize.min,

                          children: [

                            Image.asset(
                              'assets/images/icon_lencana.png',

                              width: 22,
                              height: 22,
                            ),

                            const SizedBox(
                              width: 8,
                            ),

                            const Text(

                              '+1 Lencana',

                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      SizedBox(

                        width: double.infinity,

                        height: 48,

                        child: ElevatedButton(

                          onPressed: () async {

                            await Navigator.pushNamed(
                              context,
                              AppRoutes.nibDetail,
                            );

                            _loadProgress();
                          },

                          style:
                              ElevatedButton.styleFrom(

                            backgroundColor:
                                const Color(
                              0xFF2D9CDB,
                            ),

                            shape:
                                RoundedRectangleBorder(

                              borderRadius:
                                  BorderRadius.circular(
                                12,
                              ),
                            ),
                          ),

                          child: Row(

                            mainAxisAlignment:
                                MainAxisAlignment.center,

                            children: [

                              Icon(

                                (simulationData?.nibCompleted ?? false)
                                    ? Icons.visibility_outlined
                                    : ((simulationData?.unlockedStep ?? 1) > 1)
                                        ? Icons.play_circle_outline
                                        : Icons.rocket_launch_outlined,

                                color: Colors.white,
                                size: 18,
                              ),

                              const SizedBox(width: 8),

                              Text(

                                (simulationData?.nibCompleted ?? false)
                                    ? 'Lihat Simulasi'
                                    : ((simulationData?.unlockedStep ?? 1) > 1)
                                        ? 'Lanjutkan Simulasi'
                                        : 'Mulai Simulasi',

                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.blue.shade50,

                  borderRadius:
                      BorderRadius.circular(16),

                  border: Border.all(
                    color: Colors.blue.shade200,
                  ),
                ),

                child: const Row(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Icon(
                      Icons.info_outline,
                      color: Color(0xFF2D9CDB),
                    ),

                    SizedBox(width: 12),

                    Expanded(

                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(
                            'Informasi Penting',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 6),

                          Text(
                            'Saat ini fitur simulasi perizinan hanya difokuskan pada pembuatan NIB.',

                            style: TextStyle(
                              height: 1.4,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}