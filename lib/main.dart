import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'themes/app_theme.dart';
import 'themes/theme_provider.dart';

import 'routes/app_routes.dart';

import 'screens/splash/splash_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/reward/reward_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/history/history_screen.dart';
import 'screens/mission/mission_screen.dart';
import 'screens/simulation/simulation_list_screen.dart';
import 'screens/simulation/nib_detail_screen.dart';
import 'screens/simulation/nib/nib_stepper_screen.dart';
import 'screens/recommendation/permit_recommendation_screen.dart';
import 'screens/guide/business_guide_screen.dart';

void main() {

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final themeProvider =
        Provider.of<ThemeProvider>(context);

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Sizinus Indonesia',

      theme: AppTheme.lightTheme,

      darkTheme: AppTheme.darkTheme,

      themeMode: themeProvider.currentTheme,

      // HALAMAN PERTAMA
      initialRoute: AppRoutes.splash,

      // ROUTES
      routes: {

        // AUTH
        AppRoutes.login: (context) =>
            const LoginScreen(),

        AppRoutes.register: (context) =>
            const RegisterScreen(),

        // MAIN
        AppRoutes.splash: (context) =>
            const SplashScreen(),

        AppRoutes.onboarding: (context) =>
        const OnboardingScreen(),

        AppRoutes.dashboard: (context) =>
            const DashboardScreen(),

        AppRoutes.reward: (context) =>
            const RewardScreen(),

        AppRoutes.history: (context) =>
            const HistoryScreen(),

        AppRoutes.mission: (context) =>
            const MissionScreen(),

        AppRoutes.settings: (context) =>
            const SettingsScreen(),

        AppRoutes.simulationList: (context) =>
            const SimulationListScreen(),

        AppRoutes.nibDetail: (context) =>
            const NibDetailScreen(),

        AppRoutes.nibStepper: (context) =>
            const NibStepperScreen(),

        AppRoutes.permitRecommendation: (context) =>
            const PermitRecommendationScreen(),

        AppRoutes.businessGuide: (context) =>
            const BusinessGuideScreen(),
                
      },
    );
  }
}