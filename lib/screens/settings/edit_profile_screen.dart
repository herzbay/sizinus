import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/session_provider.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_topbar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {

  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    final user = context.read<SessionProvider>().currentUser;

    nameController = TextEditingController(
      text: user?.fullName ?? '',
    );

    emailController = TextEditingController(
      text: user?.email ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void saveProfile() {

    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Nama lengkap wajib diisi.',
          ),
        ),
      );
      return;
    }

    final emailRegex = RegExp(
      r'^[^@]+@[^@]+\.[^@]+$',
    );

    if (!emailRegex.hasMatch(
      emailController.text.trim(),
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Format email tidak valid.',
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Siap dihubungkan ke Firebase.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF5F5F5),

      appBar: const CustomTopBar(
        showBackButton: true,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              'Kelola Akun',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Perbarui informasi akun Anda.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 30),

            Center(

              child: Container(

                width: 110,
                height: 110,

                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: 0.06,
                      ),
                      blurRadius: 10,
                    ),
                  ],
                ),

                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Image.asset(
                    'assets/images/icon_user.png',
                  ),
                ),
              ),
            ),

            const SizedBox(height: 36),

            const Text(
              'Nama Lengkap',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            CustomTextField(
              hintText: 'Nama Lengkap',
              prefixIcon: Icons.person_outline,
              controller: nameController,
              textInputAction:
                  TextInputAction.next,
            ),

            const SizedBox(height: 22),

            const Text(
              'Email',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            CustomTextField(
              hintText: 'Email',
              prefixIcon: Icons.email_outlined,
              controller: emailController,
              keyboardType:
                  TextInputType.emailAddress,
              textInputAction:
                  TextInputAction.done,
            ),

            const SizedBox(height: 30),

            const Divider(),

            const SizedBox(height: 10),

            const Text(
              'Keamanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ListTile(

              contentPadding: EdgeInsets.zero,

              leading: Container(
                width: 46,
                height: 46,

                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius:
                      BorderRadius.circular(14),
                ),

                child: const Icon(
                  Icons.lock_outline,
                  color: Colors.orange,
                ),
              ),

              title: const Text(
                'Ubah Password',
              ),

              subtitle: const Text(
                'Perbarui kata sandi akun',
              ),

              trailing: const Icon(
                Icons.chevron_right_rounded,
              ),

              onTap: () {

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Fitur ubah password akan segera tersedia.',
                    ),
                  ),
                );

              },
            ),

            const SizedBox(height: 36),

            SizedBox(

              width: double.infinity,

              height: 56,

              child: FilledButton(

                onPressed: saveProfile,

                style: FilledButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF2D9CDB),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                ),

                child: const Text(
                  'SIMPAN',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}