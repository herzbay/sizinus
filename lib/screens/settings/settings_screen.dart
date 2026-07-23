import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/custom_topbar.dart';

import '../../services/auth/local_auth_service.dart';
import 'package:provider/provider.dart';
import '../../providers/session_provider.dart';


class SettingsScreen
    extends StatelessWidget {

  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context,) {

    return Scaffold(

      appBar: const CustomTopBar(
        showBackButton: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Pengaturan',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Kelola akun dan preferensi aplikasi Anda.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 28),

          const Text(
            'PROFIL',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 1.1,
            ),
          ),

          const SizedBox(height: 12),

          _menuTile(
            context,
            icon: Icons.person_outline,
            title: 'Profil Saya',
            subtitle: 'Lihat informasi akun',
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.profile,
              );
            },
          ),

          const SizedBox(height: 16),

          const Text(
            'INFORMASI',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 1.1,
            ),
          ),

          const SizedBox(height: 12),

          _menuTile(
            context,
            icon: Icons.info_outline,
            title: 'Tentang Aplikasi',
            subtitle: 'Informasi mengenai SIZINUS',
            onTap: () {},
          ),

          _menuTile(
            context,
            icon: Icons.privacy_tip_outlined,
            title: 'Kebijakan Privasi',
            subtitle: 'Syarat dan ketentuan penggunaan',
            onTap: () {},
          ),

          const SizedBox(
            height: 24,
          ),

          const SizedBox(height: 16),

          const Text(
            'AKUN',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 1.1,
            ),
          ),

          const SizedBox(height: 12),

          _menuTile(
            context,
            icon: Icons.logout,
            title: 'Keluar Akun',
            subtitle: 'Keluar dari sesi saat ini',
            isLogout: true,
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Keluar Akun'),
                  content: const Text(
                    'Apakah Anda yakin ingin keluar dari akun ini?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('Batal'),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Keluar'),
                    ),
                  ],
                ),
              );

              if (confirm != true) return;

              await LocalAuthService().logout();

              if (!context.mounted) return;

              context.read<SessionProvider>().clear();

              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (_) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _menuTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {

  return Container(
    margin: const EdgeInsets.only(bottom: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),

      leading: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: isLogout
              ? Colors.red.shade50
              : const Color(0xFF2D9CDB)
                  .withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(
          icon,
          color: isLogout
              ? Colors.red
              : const Color(0xFF2D9CDB),
        ),
      ),

      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isLogout ? Colors.red : Colors.black,
        ),
      ),

      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13,
          ),
        ),
      ),

      trailing: Icon(
        Icons.chevron_right_rounded,
        color:
            isLogout ? Colors.red : Colors.grey.shade400,
      ),

      onTap: onTap,
    ),
  );
  }
}