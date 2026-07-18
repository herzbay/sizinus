import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {

    emailController.dispose();

    passwordController.dispose();

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

                'Selamat Datang 👋',

                style: TextStyle(

                  fontSize: 32,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(

                'Masuk ke akun Anda untuk melanjutkan progres simulasi perizinan usaha.',

                style: TextStyle(

                  color: Colors.grey,

                  height: 1.5,

                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 28),

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
                hintText: 'Masukkan alamat email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 26),

              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Masukkan password',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),

                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword =
                            !obscurePassword;
                      });
                    },

                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),

                  filled: true,
                  fillColor: Colors.grey.shade100,

                  contentPadding:
                      const EdgeInsets.symmetric(
                    vertical: 18,
                  ),

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFF1296DB),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 26),

              SizedBox(
                width: double.infinity,
                height: 58,

                child: ElevatedButton.icon(

                  onPressed: () {

                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.dashboard,
                    );
                  },

                  icon: const Icon(
                    Icons.login_rounded,
                    color: Colors.white,
                  ),

                  label: const Text(
                    'Masuk',
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

              const SizedBox(height: 28),

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
                    // FirebaseAuth Google Sign In
                  },

                  icon: Image.asset(
                    'assets/images/logo_google.png',
                    width: 22,
                    height: 22,
                  ),

                  label: const Text(
                    'Masuk dengan Google',
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

                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),

                    children: [

                      const TextSpan(
                        text: 'Belum memiliki akun? ',
                      ),

                      WidgetSpan(
                        alignment:
                            PlaceholderAlignment.middle,

                        child: GestureDetector(
                          onTap: () {

                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.register,
                            );
                          },

                          child: const Text(
                            'Daftar Sekarang',

                            style: TextStyle(
                              color: Color(0xFF1296DB),

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

              const SizedBox(height: 30),

              ],
            ),
          ),
        ),
      );
    }
}