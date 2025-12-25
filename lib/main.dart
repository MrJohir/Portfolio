import 'package:flutter/material.dart';

import 'package:portfolio/core/utils/theme/app_theme.dart';
import 'package:portfolio/features/home/views/screens/home_page.dart';

void main() {
  runApp(const PortfolioApp());
}

/// Main application widget
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Md. Johirul Islam',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const HomePage(),
    );
  }
}
