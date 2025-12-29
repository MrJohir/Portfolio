import 'package:flutter/material.dart';
import 'package:portfolio/core/common/widgets/nav_bar.dart';
import 'package:portfolio/core/services/scroll_service.dart';
import 'package:portfolio/features/home/views/widgets/about_section.dart';
import 'package:portfolio/features/home/views/widgets/skill_section.dart';
import 'package:portfolio/features/home/views/widgets/footer_section.dart';
import 'package:portfolio/features/home/views/widgets/hero_section.dart';
import 'package:portfolio/features/home/views/widgets/process_section.dart';
import 'package:portfolio/features/home/views/widgets/my_projects_section.dart';
import 'package:portfolio/features/home/views/widgets/services_section.dart';

/// Home page screen - main portfolio landing page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollService = ScrollService.instance;

    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollService.scrollController,
        child: Column(
          children: [
            // Navigation bar
            const NavBar(),
            // Hero section (Home)
            HeroSection(key: scrollService.homeKey),
            // About section with 3 cards
            AboutSection(key: scrollService.aboutKey),
            // Recent work section (Projects)
            MyProjects(key: scrollService.projectsKey),
            // Blog section (Skills)
            SkillSection(key: scrollService.blogKey),
            // Process section (6 steps)
            const ProcessSection(),
            // Services section
            ServicesSection(key: scrollService.servicesKey),
            // // Testimonials section
            // TestimonialsSection(),

            // Footer with contact form
            FooterSection(key: scrollService.contactKey),
          ],
        ),
      ),
    );
  }
}
