import 'package:flutter/material.dart';

import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_topbar.dart';
import '../../services/auth/firebase_auth_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    super.key,
  });

  @override
  State<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState
    extends State<ChangePasswordScreen> {

  final oldPasswordController =
      TextEditingController();

  final newPasswordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  final FirebaseAuthService authService =
      FirebaseAuthService();

  bool isLoading = false;

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> changePassword() async {
    final oldPassword =
        oldPasswordController.text.trim();

    final newPassword =
        newPasswordController.text.trim();

    final confirmPassword =
        confirmPasswordController.text.trim();

    if (oldPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password lama wajib diisi.',
          ),
        ),
      );
      return;
    }

    if (newPassword.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password baru minimal 8 karakter.',
          ),
        ),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Konfirmasi password tidak sama.',
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final success =
        await authService.changePassword(
      currentPassword: oldPassword,
      newPassword: newPassword,
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password lama salah atau gagal mengubah password.',
          ),
        ),
      );
      return;
    }

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {

    return PopScope(

      canPop: !isLoading,

      child: Scaffold(

        backgroundColor: const Color(0xFFF5F5F5),

        appBar: const CustomTopBar(
          showBackButton: true,
        ),

        body: SafeArea(

          child: SingleChildScrollView(

            padding: EdgeInsets.fromLTRB(
              20,
              20,
              20,
              MediaQuery.of(context).padding.bottom + 16,
            ),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const Text(
                  'Ubah Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Perbarui kata sandi akun Anda.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 28),

                const Text(
                  'Password Lama',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                CustomTextField(
                  hintText: 'Masukkan password lama',
                  prefixIcon: Icons.lock_outline,
                  controller: oldPasswordController,
                  obscureText: true,
                  enabled: !isLoading,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Password Baru',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                CustomTextField(
                  hintText: 'Masukkan password baru',
                  prefixIcon: Icons.lock_reset_outlined,
                  controller: newPasswordController,
                  obscureText: true,
                  enabled: !isLoading,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Konfirmasi Password',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                CustomTextField(
                  hintText:
                      'Masukkan ulang password baru',
                  prefixIcon: Icons.verified_user_outlined,
                  controller:
                      confirmPasswordController,
                  obscureText: true,
                  enabled: !isLoading,
                  textInputAction:
                      TextInputAction.done,
                ),

                const SizedBox(height: 24),

                Container(

                  padding:
                      const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius:
                        BorderRadius.circular(14),
                  ),

                  child: Row(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Icon(
                        Icons.info_outline,
                        color: Color(0xFF2D9CDB),
                      ),

                      const SizedBox(width: 12),

                      Expanded(

                        child: Text(
                          'Password harus terdiri dari minimal 8 karakter agar keamanan akun tetap terjaga.',
                          style: TextStyle(
                            color:
                                Colors.grey.shade700,
                            fontSize: 13,
                          ),
                        ),

                      ),

                    ],

                  ),

                ),

                const SizedBox(height: 32),

                SizedBox(

                  width: double.infinity,

                  height: 52,

                  child: FilledButton(

                    onPressed: isLoading
                        ? null
                        : changePassword,

                    style:
                        FilledButton.styleFrom(
                      backgroundColor:
                          const Color(
                        0xFF2D9CDB,
                      ),
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),

                    child: isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'SIMPAN',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                  ),

                ),

              ],

            ),

          ),

        ),

      ),

    );

  }

}