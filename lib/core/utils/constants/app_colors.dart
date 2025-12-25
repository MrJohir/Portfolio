import 'package:flutter/material.dart';

/// App color constants matching HTML design
class AppColors {
  AppColors._();

  // Primary colors
  static const Color primary = Color(0xFF558B2F); // Leafy Green
  static const Color primaryHover = Color(0xFF426E23);

  // Background colors
  static const Color backgroundLight = Color(
    0xFFF2F4EC,
  ); // Very light greenish-beige
  static const Color backgroundDark = Color(0xFF0F172A); // Slate 900

  // Surface colors
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B);

  // Text colors
  static const Color textPrimary = Color(0xFF111827); // gray-900
  static const Color textSecondary = Color(0xFF4B5563); // gray-600
  static const Color textMuted = Color(0xFF6B7280); // gray-500
  static const Color textLight = Color(0xFF9CA3AF); // gray-400
  static const Color textDark = Color(0xFF9CA3AF); // For dark backgrounds

  // Dark mode text
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
  static const Color textMutedDark = Color(0xFF6B7280);

  // Border colors
  static const Color borderLight = Color(0xFFE5E7EB); // gray-200
  static const Color borderDark = Color(0xFF374151); // gray-700

  // Card backgrounds
  static const Color cardLight = Color(0xFFF9FAFB); // gray-50
  static const Color cardDark = Color(0xFF1F2937); // gray-800

  // Accent colors
  static const Color orange = Color(0xFFF97316);
  static const Color green = Color(0xFF22C55E);
  static const Color blue = Color(0xFF3B82F6);
  static const Color purple = Color(0xFFA855F7);
  static const Color red = Color(0xFFEF4444);
  static const Color indigo = Color(0xFF6366F1);

  // Error color
  static const Color error = Color(0xFFEF4444);

  // Footer background
  static const Color footerLight = Color(0xFFF0F2EB);
  static const Color footerDark = Color(0xFF000000);

  // Gradient overlay
  static const Color overlayBlack = Color(0xCC000000);
  static const Color overlayTransparent = Colors.transparent;
}
