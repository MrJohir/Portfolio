import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:portfolio/core/utils/constants/app_colors.dart';

/// App text styles matching HTML design (Inter font family)
class AppTextStyles {
  AppTextStyles._();

  // Base text style with Inter font
  static TextStyle get _baseStyle => GoogleFonts.inter();

  // Hero title - text-4xl lg:text-5xl font-bold
  static TextStyle get heroTitle => _baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.1,
    color: AppColors.textPrimary,
  );

  // Section title - text-2xl font-bold
  static TextStyle get sectionTitle => _baseStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // Subheading - text-xl font-semibold
  static TextStyle get subheading => _baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Card title - text-lg font-bold
  static TextStyle get cardTitle => _baseStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // Subtitle - text-lg
  static TextStyle get subtitle => _baseStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // Body text - text-sm
  static TextStyle get body => _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  // Body text alias
  static TextStyle get bodyText => body;

  // Small text - text-xs
  static TextStyle get small => _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  // Extra small - text-[10px]
  static TextStyle get extraSmall => _baseStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  // Button text - text-sm font-medium
  static TextStyle get button => _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  // Navigation link - text-sm font-medium
  static TextStyle get navLink => _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  // Brand name - font-bold text-xl
  static TextStyle get brandName => _baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  // Uppercase label - text-xs font-semibold uppercase tracking-wider
  static TextStyle get label => _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    color: AppColors.textMuted,
  );

  // Primary accent text
  static TextStyle get primaryAccent => _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  // Work experience title - font-bold text-sm
  static TextStyle get workTitle => _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // Footer title - text-3xl font-bold
  static TextStyle get footerTitle => _baseStyle.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
}
