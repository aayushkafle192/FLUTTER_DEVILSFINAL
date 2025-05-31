import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color.fromARGB(255, 53, 53, 53),

    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Poppins',
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
