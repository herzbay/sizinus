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

        padding:
            const EdgeInsets.all(
          20,
        ),

        children: [

          _menuTile(
            context,
            icon: Icons.person_outline,
            title: 'Profil Saya',
            onTap: () {

              Navigator.pushNamed(
                context,
                AppRoutes.profile,
              );
            },
          ),

          _menuTile(
            context,
            icon: Icons.info_outline,
            title: 'Tentang Aplikasi',
            onTap: () {},
          ),

          _menuTile(
            context,
            icon: Icons.privacy_tip_outlined,
            title: 'Kebijakan Privasi',
            onTap: () {},
          ),

          _menuTile(
            context,
            icon: Icons.refresh,
            title:
                'Reset Simulasi NIB',
            onTap: () {},
          ),

          const SizedBox(
            height: 24,
          ),

          _menuTile(
            context,
            icon: Icons.logout,
            title: 'Keluar Akun',
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
    required VoidCallback onTap,
  }) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 12,
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

      child: ListTile(

        leading: Icon(
          icon,
        ),

        title: Text(
          title,
        ),

        trailing: const Icon(
          Icons.chevron_right,
        ),

        onTap: onTap,
      ),
    );
  }
}