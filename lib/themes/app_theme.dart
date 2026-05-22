import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {

  // LIGHT THEME
  static ThemeData lightTheme = ThemeData(

    brightness: Brightness.light,

    scaffoldBackgroundColor: AppColors.lightBackground,

    fontFamily: 'Roboto',

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
    ),

    cardColor: AppColors.lightCard,

    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: AppColors.lightText,
      ),
    ),
  );

  // DARK THEME
  static ThemeData darkTheme = ThemeData(

    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.darkBackground,

    fontFamily: 'Roboto',

    cardColor: AppColors.darkCard,

    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: AppColors.darkText,
      ),
    ),
  );
}