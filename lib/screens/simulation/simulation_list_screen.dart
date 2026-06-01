import 'package:flutter/material.dart';

import '../../widgets/custom_topbar.dart';
import '../../widgets/custom_bottom_navbar.dart';
import '../../routes/app_routes.dart';

class SimulationListScreen
    extends StatelessWidget {

  const SimulationListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: const CustomTopBar(),

      body: Padding(

        padding: const EdgeInsets.all(18),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

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
            ),

            const SizedBox(height: 24),

            Card(
              elevation: 3,

              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: InkWell(

                borderRadius:
                    BorderRadius.circular(20),

                onTap: () {

                  Navigator.pushNamed(
                    context,
                    AppRoutes.nibDetail,
                  );
                },

                child: Padding(

                  padding:
                      const EdgeInsets.all(20),

                  child: Row(

                    children: [

                      Container(
                        width: 60,
                        height: 60,

                        decoration:
                            BoxDecoration(
                          color:
                              Colors.blue.shade50,

                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),
                        ),

                        child: const Icon(
                          Icons.badge,
                          size: 32,
                          color:
                              Color(0xFF2D9CDB),
                        ),
                      ),

                      const SizedBox(width: 16),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Text(
                              'Nomor Induk Berusaha (NIB)',

                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              'Simulasi OSS Detail',
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar:
          CustomBottomNavbar(
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}