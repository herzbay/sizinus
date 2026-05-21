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
    return Container(
      margin: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2D9CDB),
            Color(0xFF27AE60),
          ],
        ),

        borderRadius: BorderRadius.circular(30),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              icon: Icons.history_rounded,
              label: 'Riwayat',
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem({
    required int index,
    required IconData icon,
    required String label,
  }) {

    final bool isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),

        decoration: BoxDecoration(
          color: isActive
              ? Colors.white24
              : Colors.transparent,

          borderRadius: BorderRadius.circular(18),
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