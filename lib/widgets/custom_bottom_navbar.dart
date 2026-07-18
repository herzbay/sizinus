import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2D9CDB),
              Color(0xFF27AE60),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.08,
              ),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 6,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            children: [
              navItem(
                index: 0,
                icon: Icons.home_rounded,
                label: 'Beranda',
              ),

              navItem(
                index: 1,
                icon: Icons.flag_rounded,
                label: 'Misi',
              ),

              navItem(
                index: 2,
                icon: Icons.workspace_premium_rounded,
                label: 'Reward',
              ),

              navItem(
                index: 3,
                icon: Icons.leaderboard_rounded,
                label: 'Peringkat',
              ),

              navItem(
                index: 4,
                icon: Icons.history_rounded,
                label: 'Riwayat',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isActive =
        currentIndex == index;

    return GestureDetector(
      onTap: () {

        // Tidak melakukan apa-apa jika sedang
        // berada di halaman yang sama.
        if (currentIndex == index) {
          return;
        }

        onTap(index);
      },

      child: AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 250,
        ),

        padding:
            const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),

        decoration: BoxDecoration(
          color: isActive
              ? Colors.white24
              : Colors.transparent,

          borderRadius:
              BorderRadius.circular(
            18,
          ),
        ),

        child: Column(
          mainAxisSize:
              MainAxisSize.min,

          children: [

            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),

            const SizedBox(
              height: 4,
            ),

            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,

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