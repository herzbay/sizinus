import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

import '../../widgets/custom_topbar.dart';

class SettingsScreen
    extends StatelessWidget {

  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

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

          SizedBox(

            height: 52,

            child: ElevatedButton.icon(

              onPressed: () {

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.red,
              ),

              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),

              label: const Text(
                'Keluar Akun',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
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