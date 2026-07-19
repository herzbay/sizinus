import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../services/auth/local_auth_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {

  final PageController _pageController =
      PageController();

  int currentPage = 0;

  final LocalAuthService auth =
      LocalAuthService();  

  final List<Map<String, dynamic>> pages = [

    {
      "icon": Icons.description_outlined,
      "title":
          "Simulasi Perizinan Jadi Lebih Mudah",
      "description":
          "Pelajari alur perizinan usaha secara interaktif tanpa harus bingung dengan proses yang rumit.",
    },

    {
      "icon": Icons.workspace_premium_outlined,
      "title":
          "Selesaikan Misi dan Dapatkan Reward",
      "description":
          "Kumpulkan XP, selesaikan misi, dan raih badge sebagai bentuk progres pembelajaran Anda.",
    },

    {
      "icon": Icons.rocket_launch_outlined,
      "title":
          "Siap Menjadi UMKM Hebat?",
      "description":
          "Mulai perjalanan memahami perizinan usaha bersama SIZINUS Indonesia.",
    },
  ];

  Future<void> nextPage() async {

    if (currentPage <
        pages.length - 1) {

      _pageController.nextPage(
        duration:
            const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

    } else {

      await auth.completeOnboarding();

      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.login,
      );
    }
  }

  Future<void> skip() async {

    await auth.completeOnboarding();

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.login,
    );
  }

  @override
  void dispose() {

    _pageController.dispose();

    super.dispose();
  }  

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [

            // TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),

              child: Row(
                children: [

                  const Spacer(),

                if (currentPage != pages.length - 1)
                  TextButton(
                    onPressed: skip,
                    child: const Text(
                      'Lewati',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // PAGE VIEW
            Expanded(
              child: PageView.builder(
                controller: _pageController,

                onPageChanged: (index) {

                  setState(() {
                    currentPage = index;
                  });
                },

                itemCount: pages.length,

                itemBuilder:
                    (context, index) {

                  final page =
                      pages[index];

                  return Padding(
                    padding:
                        const EdgeInsets.all(
                      24,
                    ),

                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,

                      children: [

                        Container(
                          width: 180,
                          height: 180,

                          decoration:
                              BoxDecoration(
                            gradient:
                                const LinearGradient(
                              colors: [
                                Color(
                                  0xFF2D9CDB,
                                ),
                                Color(
                                  0xFF27AE60,
                                ),
                              ],
                            ),

                            borderRadius:
                                BorderRadius
                                    .circular(
                              40,
                            ),
                          ),

                          child: Icon(
                            page["icon"],

                            size: 90,
                            color:
                                Colors.white,
                          ),
                        ),

                        const SizedBox(
                          height: 50,
                        ),

                        Text(
                          page["title"],

                          textAlign:
                              TextAlign.center,

                          style:
                              const TextStyle(
                            fontSize: 28,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 18,
                        ),

                        Text(
                          page["description"],

                          textAlign:
                              TextAlign.center,

                          style:
                              const TextStyle(
                            fontSize: 17,
                            color:
                                Colors.black54,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // INDICATOR
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: List.generate(
                pages.length,
                (index) {

                  return AnimatedContainer(
                    duration:
                        const Duration(
                      milliseconds: 250,
                    ),

                    margin:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 4,
                    ),

                    width:
                        currentPage == index
                        ? 24
                        : 8,

                    height: 8,

                    decoration:
                        BoxDecoration(
                      color:
                          currentPage ==
                              index
                          ? const Color(
                              0xFF2D9CDB,
                            )
                          : Colors.grey
                                .shade300,

                      borderRadius:
                          BorderRadius
                              .circular(
                        20,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // BUTTON
            Padding(
              padding:
                  const EdgeInsets.all(24),

              child: SizedBox(
                width: double.infinity,
                height: 56,

                child: ElevatedButton(
                  onPressed: nextPage,

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(
                      0xFF2D9CDB,
                    ),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        16,
                      ),
                    ),
                  ),

                  child: Text(
                    currentPage ==
                            pages.length - 1
                        ? "Mulai Belajar"
                        : "Lanjut",

                    style:
                        const TextStyle(
                      color:
                          Colors.white,
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
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