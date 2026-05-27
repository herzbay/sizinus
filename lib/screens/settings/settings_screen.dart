import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../themes/theme_provider.dart';
import '../../widgets/custom_bottom_navbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final themeProvider =
        Provider.of<ThemeProvider>(context);

    return Scaffold(

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),

        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF2D9CDB),
                Color(0xFF27AE60),
              ],
            ),
          ),

          child: SafeArea(
            child: Row(
              children: [

                Container(
                  width: 42,
                  height: 42,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: const Icon(
                    Icons.business_center,
                    color: Color(0xFF2D9CDB),
                  ),
                ),

                const SizedBox(width: 12),

                const Text(
                  'SIZINUS',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            18,
            18,
            18,
            24,
          ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // HEADER
            Row(
              children: [

                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 12),

                const Text(
                  'Pengaturan',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // DARK MODE
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2D9CDB),
                    Color(0xFF27AE60),
                  ],
                ),

                borderRadius: BorderRadius.circular(18),
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    'Ubah Mode Layar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Switch(
                    value: themeProvider.isDarkMode,

                    onChanged: (value) {
                      themeProvider.toggleTheme(value);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // INFO AKUN
            const Text(
              'Info Akun',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2D9CDB),
                    Color(0xFF27AE60),
                  ],
                ),

                borderRadius: BorderRadius.circular(18),
              ),

              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    'Nama          : Bayu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Email          : bayu@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'No. Telepon : +62-813-4928-3429',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // EDIT PROFILE CARD
            const Text(
              'Profil',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            settingsCard(
              icon: Icons.edit,
              title: 'Ubah Profil',
              subtitle: 'Edit nama, email, dan nomor telepon',
              color: Colors.orange,
            ),

            const SizedBox(height: 35),

            // PINDAH AKUN
            const Text(
              'Pindah Akun',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            accountCard(
              name: 'Maulana',
            ),

            const SizedBox(height: 16),

            accountCard(
              name: 'Agung',
            ),

            const SizedBox(height: 50),

            // LOGOUT BUTTON
            SizedBox(
              width: double.infinity,
              height: 60,

              child: ElevatedButton(
                onPressed: () {},

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                ),

                child: const Text(
                  'Keluar Akun',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 120),
          ],
        ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }

  // SETTINGS CARD
  Widget settingsCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2D9CDB),
            Color(0xFF27AE60),
          ],
        ),

        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [

          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // ACCOUNT CARD
  Widget accountCard({
    required String name,
  }) {

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2D9CDB),
            Color(0xFF27AE60),
          ],
        ),

        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [

          const CircleAvatar(
            backgroundColor: Colors.white,

            child: Icon(
              Icons.person,
              color: Colors.blue,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}