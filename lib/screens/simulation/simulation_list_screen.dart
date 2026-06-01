import 'package:flutter/material.dart';

import '../../widgets/custom_topbar.dart';
import '../../routes/app_routes.dart';

class SimulationListScreen extends StatelessWidget {
  const SimulationListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomTopBar(),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const Text(
                'Simulasi Perizinan',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
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
                      BorderRadius.circular(24),

                  border: Border.all(
                    color: const Color(
                      0xFF2D9CDB,
                    ),
                    width: 1.2,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: 0.06,
                      ),

                      blurRadius: 10,

                      offset: const Offset(
                        0,
                        4,
                      ),
                    ),
                  ],
                ),

                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(24),

                  onTap: () {

                    Navigator.pushNamed(
                      context,
                      AppRoutes.nibDetail,
                    );
                  },

                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Row(
                      children: [

                        // ICON NIB
                        Container(
                          width: 90,
                          height: 90,

                          padding:
                              const EdgeInsets.all(
                            10,
                          ),

                          decoration:
                              BoxDecoration(
                            color:
                                Colors.blue.shade50,

                            borderRadius:
                                BorderRadius
                                    .circular(
                              18,
                            ),
                          ),

                          child: Image.asset(
                            'assets/images/icon_nib.png',
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(width: 18),

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

                                  fontSize: 20,

                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              const Text(
                                'Simulasi pembuatan NIB online berdasarkan alur OSS Indonesia.',

                                style: TextStyle(
                                  color:
                                      Colors.black87,

                                  fontSize: 14,

                                  height: 1.4,
                                ),
                              ),

                              const SizedBox(
                                height: 14,
                              ),

                              Container(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),

                                decoration:
                                    BoxDecoration(
                                  color:
                                      const Color(
                                    0xFFEAF7EE,
                                  ),

                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    20,
                                  ),
                                ),

                                child: Row(
                                  mainAxisSize:
                                      MainAxisSize
                                          .min,

                                  children: [

                                    Image.asset(
                                      'assets/images/icon_xp.png',
                                      width: 22,
                                      height: 22,
                                    ),

                                    const SizedBox(
                                      width: 6,
                                    ),

                                    Text(
                                      '+150',

                                      style:
                                          TextStyle(
                                        color: const Color(0xFF000000),

                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        const Icon(
                          Icons.arrow_forward_ios,
                          color:
                              Color(0xFF2D9CDB),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.only(
                  bottom: 6,
                ),

                child: SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
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
                            BorderRadius
                                .circular(
                          14,
                        ),
                      ),
                    ),

                    child: const Text(
                      'Kembali',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
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