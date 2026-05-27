import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  // NAVIGATION FUNCTION
  void navigate(
    BuildContext context,
    int index,
  ) {

    String route;

    switch (index) {

      case 0:
        route = AppRoutes.dashboard;
        break;

      case 1:
        route = AppRoutes.mission;
        break;

      case 2:
        route = AppRoutes.reward;
        break;

      case 3:
        route = AppRoutes.history;
        break;

      default:
        route = AppRoutes.dashboard;
    }

    // AGAR TIDAK NAVIGATE KE HALAMAN YANG SAMA
    if (currentIndex == index) return;

    Navigator.pushReplacementNamed(
      context,
      route,
    );
  }

  @override
  Widget build(BuildContext context) {

    final bottomInset =
        MediaQuery.of(context).padding.bottom;

    return SafeArea(

      top: false,

      child: Container(

        width: double.infinity,

        margin: EdgeInsets.only(
          left: 0,
          right: 0,
          bottom: bottomInset,
        ),

        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),

        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2D9CDB),
              Color(0xFF27AE60),
            ],
          ),

          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.08,
              ),

              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,

          children: [

            navItem(
              context: context,
              index: 0,
              icon: Icons.home_rounded,
              label: 'Beranda',
            ),

            navItem(
              context: context,
              index: 1,
              icon: Icons.flag_rounded,
              label: 'Misi',
            ),

            navItem(
              context: context,
              index: 2,
              icon:
                  Icons.workspace_premium_rounded,
              label: 'Reward',
            ),

            navItem(
              context: context,
              index: 3,
              icon: Icons.history_rounded,
              label: 'Riwayat',
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required String label,
  }) {

    final bool isActive =
        currentIndex == index;

    return GestureDetector(

      onTap: () {

        onTap(index);

        navigate(context, index);
      },

      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 250),

        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          color: isActive
              ? Colors.white24
              : Colors.transparent,

          borderRadius:
              BorderRadius.circular(18),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Icon(
              icon,
              color: Colors.white,
              size: 26,
            ),

            const SizedBox(height: 4),

            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,

                fontWeight: isActive
                    ? FontWeight.bold
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}