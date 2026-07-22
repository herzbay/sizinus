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

              padding:
                  const EdgeInsets.all(
                20,
              ),

              child: Column(

                children: [

                  CircleAvatar(
                    radius: 48,
                    backgroundColor:
                        Colors.blue.shade50,
                    child: Icon(
                      Icons.person,
                      size: 52,
                      color:
                          Colors.blue.shade400,
                    ),
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

                  _statCard(
                    'Total Poin',
                    '${session.totalPoint}',
                    Icons.stars,
                  ),

                  _statCard(
                    'Total Badge',
                    '${session.badgeCount}',
                    Icons.workspace_premium,
                  ),

                  _statCard(
                    'Panduan Selesai',
                    '${session.completedGuideCount}',
                    Icons.menu_book,
                  ),

                  _statCard(
                    'Simulasi Selesai',
                    session.nibCompleted
                        ? '1'
                        : '0',
                    Icons.business,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _statCard(
    String title,
    String value,
    IconData icon,
  ) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),

      padding:
          const EdgeInsets.all(
        16,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          18,
        ),

        border: Border.all(
          color:
              Colors.grey.shade200,
        ),
      ),

      child: Row(

        children: [

          Icon(
            icon,
            color:
                const Color(
              0xFF2D9CDB,
            ),
          ),

          const SizedBox(
            width: 12,
          ),

          Expanded(
            child: Text(
              title,
            ),
          ),

          Text(
            value,
            style:
                const TextStyle(
              fontWeight:
                  FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}