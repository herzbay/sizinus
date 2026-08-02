import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/custom_topbar.dart';

import '../../services/auth/firebase_auth_service.dart';
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
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          MediaQuery.of(context).padding.bottom + 8,
        ),
        children: [
          const Text(
            'Pengaturan',
            style: TextStyle(
              fontSize: 26,
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

          const SizedBox(height: 20),

          const Text(
            'PROFIL',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 1.1,
            ),
          ),

          const SizedBox(height: 8),

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

          _menuTile(
            context,
            icon: Icons.manage_accounts_outlined,
            title: 'Kelola Akun',
            subtitle: 'Ubah informasi akun',
            onTap: () async {
              final result = await Navigator.pushNamed(
                context,
                AppRoutes.account,
              );

              if (!context.mounted) return;

              if (result == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Profil berhasil diperbarui.',
                    ),
                  ),
                );
              }
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

          const SizedBox(height: 8),

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
            height: 14,
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

          const SizedBox(height: 8),

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

              await FirebaseAuthService().logout();

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
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(
          horizontal: 0,
          vertical: -2,
        ),
        minLeadingWidth: 0,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 6,
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isLogout
                ? Colors.red.shade50
                : const Color(0xFF2D9CDB)
                    .withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isLogout
                ? Colors.red
                : const Color(0xFF2D9CDB),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isLogout ? Colors.red : Colors.black,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          size: 20,
          color: isLogout
              ? Colors.red
              : Colors.grey.shade400,
        ),
        onTap: onTap,
      ),
    );
  }
}