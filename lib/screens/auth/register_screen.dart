import 'package:flutter/material.dart';

import '../../widgets/custom_textfield.dart';
import '../../routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {

    nameController.dispose();

    emailController.dispose();

    passwordController.dispose();

    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 60),

              const Text(

                'Buat Akun',

                style: TextStyle(

                  fontSize: 32,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(

                'Lengkapi data berikut untuk membuat akun baru.',

                style: TextStyle(

                  color: Colors.grey,

                  fontSize: 16,

                  height: 1.5,
                ),
              ),

              const SizedBox(height: 34),

              const Text(

                'Nama Lengkap',

                style: TextStyle(

                  fontSize: 17,

                  fontWeight:
                      FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              CustomTextField(
                controller: nameController,
                hintText:
                    'Masukkan nama lengkap',
                prefixIcon:
                    Icons.person_outline,
              ),

              const SizedBox(height: 24),

              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              CustomTextField(
                controller: emailController,
                hintText:
                    'Masukkan alamat email',
                prefixIcon:
                    Icons.email_outlined,
                keyboardType:
                    TextInputType.emailAddress,
              ),

              const SizedBox(height: 24),

              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              CustomTextField(
                controller: passwordController,
                hintText: 'Masukkan password',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
              ),

              const SizedBox(height: 24),

              const Text(
                'Konfirmasi Password',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'Masukkan kembali password',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
              ),

              const SizedBox(height: 34),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO:
                    // Register Firebase Authentication

                    Navigator.pop(context);
                  },

                  icon: const Icon(
                    Icons.person_add_alt_1_rounded,
                    color: Colors.white,
                  ),

                  label: const Text(
                    'Daftar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF1296DB),

                    elevation: 2,

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 34),

              Row(
                children: [

                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Text(
                      'atau',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO:
                    // Google Sign Up
                  },

                  icon: Image.asset(
                    'assets/images/logo_google.png',
                    width: 22,
                    height: 22,
                  ),

                  label: const Text(
                    'Daftar dengan Google',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,

                    side: BorderSide(
                      color: Colors.grey.shade300,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),

                    children: [

                      const TextSpan(
                        text: 'Sudah memiliki akun? ',
                      ),

                      WidgetSpan(
                        alignment:
                            PlaceholderAlignment.middle,

                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.login,
                            );
                          },

                          child: const Text(
                            'Masuk',

                            style: TextStyle(
                              color: Color(0xFF1296DB),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}              