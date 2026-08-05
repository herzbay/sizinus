import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes/app_routes.dart';

import '../../providers/session_provider.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_topbar.dart';

import '../../models/auth/user_model.dart';
import '../../services/auth/firebase_auth_service.dart';
import '../../services/user/firestore_user_service.dart';

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

  final FirebaseAuthService authService =
      FirebaseAuthService();

  final FirestoreUserService firestoreService =
      FirestoreUserService();

  bool isLoading = false;  

  @override
  void initState() {
    super.initState();

    final user = Provider.of<SessionProvider>(
      context,
      listen: false,
    ).currentUser;

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

  Future<void> saveProfile() async {

    final currentUser =
        Provider.of<SessionProvider>(
          context,
          listen: false,
        ).currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Data pengguna tidak ditemukan.',
          ),
        ),
      );
      return;
    }

    final fullName =
        nameController.text.trim();

    if (fullName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Nama lengkap wajib diisi.',
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final user = UserModel(
      fullName: fullName,
      email: currentUser.email,
      password: '',
    );

    final authSuccess =
        await authService.updateProfile(user);

    if (!mounted) return;

    if (!authSuccess) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Gagal memperbarui profil.',
          ),
        ),
      );
      return;
    }

    final uid =
        authService.getCurrentUserUid();

    if (uid == null) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'UID pengguna tidak ditemukan.',
          ),
        ),
      );
      return;
    }

    final firestoreSuccess =
        await firestoreService.updateUser(
      uid: uid,
      user: user,
    );

    if (!mounted) return;

    if (!firestoreSuccess) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Gagal menyimpan data ke database.',
          ),
        ),
      );

      return;
    }

    if (!mounted) return;

    context
        .read<SessionProvider>()
        .updateUser(user);

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
              'Kelola Akun',
              style: TextStyle(
                fontSize: 26,
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

            const SizedBox(height: 24),

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

            const SizedBox(height: 28),

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
              textInputAction: TextInputAction.next,
              enabled: !isLoading,
            ),

            const SizedBox(height: 16),

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
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              readOnly: true,
              enabled: false,
            ),

            const SizedBox(height: 6),

            Text(
              'Email digunakan sebagai akun login dan tidak dapat diubah.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 6),

            const Divider(),

            const SizedBox(height: 8),

            const Text(
              'Keamanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Container(
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
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.lock_outline,
                    size: 20,
                    color: Colors.orange,
                  ),
                ),
                title: const Text(
                  'Ubah Password',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Perbarui kata sandi akun',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: Colors.grey.shade400,
                ),
                
                onTap: isLoading
                    ? null
                    : () async {
                        final messenger = ScaffoldMessenger.of(context);

                        final result = await Navigator.pushNamed(
                          context,
                          AppRoutes.changePassword,
                        );

                        if (!mounted) return;

                        if (result == true) {
                          messenger.showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Password berhasil diperbarui.',
                              ),
                            ),
                          );
                        }
                      },
              ),
            ),

            const SizedBox(height: 26),

            SizedBox(

              width: double.infinity,

              height: 52,

              child: FilledButton(

                onPressed: isLoading
                    ? null
                    : saveProfile,

                style: FilledButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF2D9CDB),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
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
                          fontWeight: FontWeight.bold,
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