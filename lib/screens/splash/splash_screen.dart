import 'dart:async';

import 'package:flutter/material.dart';

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

  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _loadingController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textOpacity;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();

    // LOGO CONTROLLER
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // TEXT CONTROLLER
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // LOADING CONTROLLER
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // ANIMATION
    _logoScale = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.elasticOut,
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
      begin: -10,
      end: 10,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeInOut,
      ),
    );

    startAnimation();
  }

  void startAnimation() async {

    _logoController.repeat(
      reverse: true,
    );

    _logoController.forward();

    await Future.delayed(
      const Duration(milliseconds: 600),
    );

    _textController.forward();

    _loadingController.forward();

    // AUTO NAVIGATE
    Timer(
      const Duration(seconds: 4),
      () {

        Navigator.pushReplacementNamed(
          context,
          AppRoutes.login,
        );
      },
    );
  }

  @override
  void dispose() {

    _logoController.dispose();
    _textController.dispose();
    _loadingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,

      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [
              Color(0xFF1E88E5),
              Color(0xFF00A86B),
            ],
          ),
        ),

        child: SafeArea(
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
                    'Simulasi Perizinan Usaha UMKM',

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // LOGO
              AnimatedBuilder(
                animation: _logoController,

                builder: (context, child) {

                  return Transform.translate(
                    offset: Offset(
                      0,
                      _floatingAnimation.value,
                    ),

                    child: FadeTransition(
                      opacity: _logoOpacity,

                      child: ScaleTransition(
                        scale: _logoScale,

                        child: Container(
                          padding:
                              const EdgeInsets.all(28),

                          decoration: BoxDecoration(
                            color: Colors.white
                                .withValues(alpha: 0.12),

                            borderRadius:
                                BorderRadius.circular(
                              34,
                            ),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withValues(
                                  alpha: 0.18,
                                ),

                                blurRadius: 30,
                                offset:
                                    const Offset(0, 14),
                              ),
                            ],
                          ),

                          child: Image.asset(
                            'assets/images/Logo_Sizinus.png',
                            width: 180,
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
                      const EdgeInsets.symmetric(
                    horizontal: 36,
                  ),

                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [

                      const Text(
                        'Sedang Memuat...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),

                      AnimatedBuilder(
                        animation: _loadingController,

                        builder: (context, child) {

                          return Text(
                            '${(_loadingController.value * 100).toInt()}%',

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
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
                    const EdgeInsets.symmetric(
                  horizontal: 36,
                ),

                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(30),

                  child: AnimatedBuilder(
                    animation: _loadingController,

                    builder: (context, child) {

                      return LinearProgressIndicator(
                        value:
                            _loadingController.value,

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

              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}