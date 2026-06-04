import 'package:flutter/material.dart';

import '../../widgets/custom_topbar.dart';
import '../../routes/app_routes.dart';

class SimulationListScreen extends StatelessWidget {
  const SimulationListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    // nanti ambil dari database
    const int currentStep = 0;
    const int totalStep = 7;

    final double progress =
        currentStep / totalStep;

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
                              const AlwaysStoppedAnimation(
                            Color(
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

                          '$currentStep / $totalStep Langkah',

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

                              '+200 XP',

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

                          onPressed: () {

                            Navigator.pushNamed(
                              context,
                              AppRoutes.nibDetail,
                            );
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

                          child: const Text(

                            'Mulai Simulasi',

                            style: TextStyle(
                              color: Colors.white,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
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
    );
  }
}