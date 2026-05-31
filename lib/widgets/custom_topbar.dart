import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class CustomTopBar extends StatelessWidget
    implements PreferredSizeWidget {

  const CustomTopBar({super.key});

  @override
  Widget build(BuildContext context) {

    return PreferredSize(
      preferredSize: preferredSize,

      child: Container(

        decoration: BoxDecoration(
          color: Colors.white,

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.05,
              ),

              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: SafeArea(
          child: Padding(

            padding:
                const EdgeInsets.symmetric(
              horizontal: 18,
            ),

            child: SizedBox(
              height: 70,

              child: Row(
                children: [

                  // LOGO
                  Container(
                    width: 46,
                    height: 46,

                    padding:
                        const EdgeInsets.all(6),

                    decoration: BoxDecoration(
                      color:
                          Colors.blue.shade50,

                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),

                    child: Image.asset(
                      'assets/images/Logo_Sizinus.png',
                    ),
                  ),

                  const SizedBox(width: 12),

                  // TITLE
                  const Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(
                        'SIZINUS',

                        style: TextStyle(
                          fontSize: 24,
                          fontWeight:
                              FontWeight.bold,

                          color:
                              Color(0xFF1565C0),

                          letterSpacing: 1,
                        ),
                      ),

                      SizedBox(height: 2),

                      Text(
                        'Simulasi Perizinan Usaha',

                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // NOTIFICATION
                  _topIconButton(
                    icon: Icons
                        .notifications_none_rounded,

                    color: Colors.orange,

                    onTap: () {},
                  ),

                  const SizedBox(width: 10),

                  // SETTINGS
                  _topIconButton(
                    icon:
                        Icons.settings_outlined,

                    color: Colors.blueAccent,

                    onTap: () {

                      Navigator.pushNamed(
                        context,
                        AppRoutes.settings,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _topIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {

    return GestureDetector(

      onTap: onTap,

      child: Container(
        width: 46,
        height: 46,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(14),

          border: Border.all(
            color: Colors.grey.shade200,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.04,
              ),

              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: Icon(
          icon,
          color: color,
          size: 24,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(78);
}