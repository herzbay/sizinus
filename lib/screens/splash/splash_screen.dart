import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import '../../services/auth/local_auth_service.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with TickerProviderStateMixin {

  final LocalAuthService auth =
      LocalAuthService();
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _loadingController;
  late AnimationController _floatingController;
  late AnimationController _bgController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textOpacity;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();

    // LOGO
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // TEXT
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // LOADING
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // FLOATING
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // BACKGROUND
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );

    // ANIMATIONS
    _logoScale = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeOutBack,
      ),
    );

    _logoOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeIn,
      ),
    );

    _textOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeIn,
      ),
    );

    _floatingAnimation = Tween<double>(
      begin: -8,
      end: 8,
    ).animate(
      CurvedAnimation(
        parent: _floatingController,
        curve: Curves.easeInOut,
      ),
    );

    startAnimation();
  }

  Future<void> startAnimation() async {
    if (!mounted) return;

    _logoController.forward();
    _textController.forward();
    _loadingController.forward();

    _floatingController.repeat(
      reverse: true,
    );

    _bgController.repeat(
      reverse: true,
    );

    await Future.delayed(
      const Duration(seconds: 5),
    );

    if (!mounted) return;

    final onboardingCompleted =
        await auth.isOnboardingCompleted();

    if (!mounted) return;

    if (!onboardingCompleted) {

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.onboarding,
      );

      return;
    }

    final loggedIn =
        await auth.isLoggedIn();

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      loggedIn
          ? AppRoutes.dashboard
          : AppRoutes.login,
    );
  }

  @override
  void dispose() {

    _logoController.dispose();
    _textController.dispose();
    _loadingController.dispose();
    _floatingController.dispose();
    _bgController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: AnimatedBuilder(
        animation: _bgController,

        builder: (context, child) {

          return Container(
            width: double.infinity,
            height: double.infinity,

            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,

                colors: [

                  Color.lerp(
                    const Color(0xFF1E88E5),
                    const Color(0xFF1565C0),
                    _bgController.value,
                  )!,

                  Color.lerp(
                    const Color(0xFF00A86B),
                    const Color(0xFF2ECC71),
                    _bgController.value,
                  )!,
                ],
              ),
            ),

            child: Stack(
              children: [

                // PARTICLE EFFECT
                ...List.generate(
                  10,
                  (index) => particle(index),
                ),

                SafeArea(
                  child: Column(
                    children: [

                      const Spacer(),

                      // TITLE
                      FadeTransition(
                        opacity: _textOpacity,

                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(
                            horizontal: 24,
                          ),

                          child: Text(
                            'Simulasi Perizinan Usaha',

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight:
                                  FontWeight.bold,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),

                      // LOGO
                      AnimatedBuilder(
                        animation:
                            _floatingController,

                        builder:
                            (context, child) {

                          return Transform.translate(
                            offset: Offset(
                              0,
                              _floatingAnimation
                                  .value,
                            ),

                            child: FadeTransition(
                              opacity:
                                  _logoOpacity,

                              child:
                                  ScaleTransition(
                                scale:
                                    _logoScale,

                                child: Container(
                                  padding:
                                      const EdgeInsets
                                          .all(28),

                                  decoration:
                                      BoxDecoration(
                                    color: Colors
                                        .white
                                        .withValues(
                                      alpha: 0.12,
                                    ),

                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      34,
                                    ),

                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors
                                            .black
                                            .withValues(
                                          alpha:
                                              0.18,
                                        ),

                                        blurRadius:
                                            30,

                                        offset:
                                            const Offset(
                                          0,
                                          14,
                                        ),
                                      ),
                                    ],
                                  ),

                                  child:
                                      Image.asset(
                                    'assets/images/Logo_Sizinus.png',
                                    width: 160,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const Spacer(),

                      // LOADING TEXT
                      FadeTransition(
                        opacity: _textOpacity,

                        child: Padding(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 36,
                          ),

                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,

                            children: [

                              const Text(
                                'Menyiapkan aplikasi...',
                                style: TextStyle(
                                  color:
                                      Colors.white,
                                  fontSize: 18,
                                ),
                              ),

                              AnimatedBuilder(
                                animation:
                                    _loadingController,

                                builder:
                                    (context,
                                        child) {

                                  return Text(
                                    '${(_loadingController.value * 100).toInt()}%',

                                    style:
                                        const TextStyle(
                                      color:
                                          Colors
                                              .white,

                                      fontSize:
                                          18,

                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // PROGRESS BAR
                      Padding(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 36,
                        ),

                        child: ClipRRect(
                          borderRadius:
                              BorderRadius
                                  .circular(
                            30,
                          ),

                          child:
                              AnimatedBuilder(
                            animation:
                                _loadingController,

                            builder:
                                (context,
                                    child) {

                              return LinearProgressIndicator(
                                value:
                                    _loadingController
                                        .value,

                                minHeight: 12,

                                backgroundColor:
                                    Colors.white24,

                                valueColor:
                                    const AlwaysStoppedAnimation(
                                  Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget particle(int index) {

    final random = Random(index);

    final size =
        random.nextDouble() * 8 + 4;

    final left =
        random.nextDouble() * 400;

    final top =
        random.nextDouble() * 800;

    return AnimatedBuilder(
      animation: _bgController,

      builder: (context, child) {

        return Positioned(
          left: left,
          top: top +
              (_bgController.value * 20),

          child: Opacity(
            opacity: 0.15,

            child: Container(
              width: size,
              height: size,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(
                  100,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}