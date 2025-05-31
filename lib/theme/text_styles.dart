import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
    color: AppColors.white,
    fontFamily: 'poppins'
  );

  static const subheading = TextStyle(
    fontSize: 16,
    color: AppColors.white70,
  );

  static const buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
}
