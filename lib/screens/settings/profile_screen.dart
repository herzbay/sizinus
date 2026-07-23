import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../providers/session_provider.dart';
import '../../widgets/custom_topbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context,) {

    final session =
    context.watch<SessionProvider>();

    final simulationData =
        session.simulationData;

    final currentUser =
        session.currentUser;

    if (simulationData == null ||
        currentUser == null) {

      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: const CustomTopBar(
        showBackButton: true,
      ),

      body : SingleChildScrollView(

              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 22,
              ),

              child: Column(

                children: [

                  Image.asset(
                    'assets/images/icon_user.png',
                    width: 96,
                    height: 96,
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Text(
                    currentUser.fullName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 4,
                  ),

                  Text(
                    'Level ${session.currentLevel}',
                    style: TextStyle(
                      color:
                          Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.85,
                    children: [

                      _statCard(
                        title: 'Total Poin',
                        value: '${session.totalPoint}',
                        image: 'assets/images/icon_xp.png',
                      ),

                      _statCard(
                        title: 'Total Lencana',
                        value: '${session.badgeCount}',
                        image: 'assets/images/icon_lencana.png',
                      ),

                      _statCard(
                        title: 'Panduan Selesai',
                        value: '${session.completedGuideCount}',
                        image: 'assets/images/icon_panduan.png',
                      ),

                      _statCard(
                        title: 'Simulasi Selesai',
                        value: session.nibCompleted ? '1' : '0',
                        image: 'assets/images/icon_simulasi.png',
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required String image,
  }) {

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.05,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset(
            image,
            width: 60,
            height: 60,
          ),

          const SizedBox(height: 14),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}