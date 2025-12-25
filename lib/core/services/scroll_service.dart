import 'package:flutter/material.dart';

/// Service to manage smooth scrolling to different sections of the portfolio
class ScrollService {
  ScrollService._();
  static final ScrollService instance = ScrollService._();

  /// ScrollController for the main page
  final ScrollController scrollController = ScrollController();

  /// GlobalKeys for each section
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey blogKey = GlobalKey();
  final GlobalKey servicesKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  /// Scroll to a specific section with smooth animation
  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  /// Scroll to home section
  void scrollToHome() => scrollToSection(homeKey);

  /// Scroll to about section
  void scrollToAbout() => scrollToSection(aboutKey);

  /// Scroll to projects section
  void scrollToProjects() => scrollToSection(projectsKey);

  /// Scroll to skills/blog section
  void scrollToSkills() => scrollToSection(blogKey);

  /// Scroll to services section
  void scrollToServices() => scrollToSection(servicesKey);

  /// Scroll to contact/footer section
  void scrollToContact() => scrollToSection(contactKey);

  /// Dispose the scroll controller
  void dispose() {
    scrollController.dispose();
  }
}
