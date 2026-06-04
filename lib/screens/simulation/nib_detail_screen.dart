import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/custom_topbar.dart';

class NibDetailScreen extends StatelessWidget {
  const NibDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomTopBar(showBackButton: true,),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              // HERO CARD
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(24),

                  border: Border.all(
                    color: const Color(
                      0xFF2D9CDB,
                    ),
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

                child: Column(
                  children: [

                    Container(
                      width: 80,
                      height: 80,

                      padding:
                          const EdgeInsets.all(
                        12,
                      ),

                      decoration:
                          BoxDecoration(
                        color:
                            Colors.blue.shade50,

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/icon_nib.png',
                          fit: BoxFit.cover,
                        ),
                      ),

                      
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Nomor Induk Berusaha',

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: 22,
                        fontWeight:
                            FontWeight.bold,

                        color: Color(
                          0xFF1565C0,
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Pelajari proses penerbitan NIB berdasarkan alur OSS Indonesia melalui simulasi interaktif.',

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // INFO CARD
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(
                  20,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(20),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: 0.05,
                      ),
                      blurRadius: 8,
                    ),
                  ],
                ),

                child: Column(
                  children: [

                    infoRow(
                      Icons.schedule,
                      'Durasi',
                      '10 - 20 Menit',
                    ),

                    const Divider(),

                    infoRow(
                      Icons.list_alt,
                      'Tahapan',
                      '7 Langkah',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // HADIAH CARD
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.amber.shade50,

                  borderRadius:
                      BorderRadius.circular(20),

                  border: Border.all(
                    color: Colors.amber.shade200,
                  ),
                ),

                child: Column(
                  children: [

                    const SizedBox(height: 2),

                    Image.asset(
                      'assets/images/icon_hadiah.png',
                      width: 150,
                      height: 150,
                    ),

                    const SizedBox(height: 2),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [

                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),
                          ),

                          child: Row(
                            children: [

                              Image.asset(
                                'assets/images/icon_xp.png',
                                width: 24,
                                height: 24,
                              ),

                              const SizedBox(width: 6),

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

                        const SizedBox(width: 12),

                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),
                          ),

                          child: Row(
                            children: [

                              Image.asset(
                                'assets/images/icon_lencana.png',
                                width: 24,
                                height: 24,
                              ),

                              const SizedBox(width: 6),

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
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // BUTTON
              Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 6,
                ),

                child: SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.nibStepper,
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
                            BorderRadius
                                .circular(
                          14,
                        ),
                      ),
                    ),

                    child: const Text(
                      'Mulai Simulasi',

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

  Widget infoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [

        Icon(
          icon,
          color: const Color(
            0xFF2D9CDB,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),

        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}