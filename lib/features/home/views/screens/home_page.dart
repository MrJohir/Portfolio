import 'package:flutter/material.dart';
import 'package:portfolio/core/common/widgets/nav_bar.dart';
import 'package:portfolio/core/services/scroll_service.dart';
import 'package:portfolio/core/utils/responsive/responsive.dart';
import 'package:portfolio/features/home/views/widgets/about_section.dart';
import 'package:portfolio/features/home/views/widgets/skill_section.dart';
import 'package:portfolio/features/home/views/widgets/footer_section.dart';
import 'package:portfolio/features/home/views/widgets/hero_section.dart';
import 'package:portfolio/features/home/views/widgets/process_section.dart';
import 'package:portfolio/features/home/views/widgets/my_projects_section.dart';
import 'package:portfolio/features/home/views/widgets/services_section.dart';

/// Home page screen - main portfolio landing page
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final scrollService = ScrollService.instance;
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      body: Column(
        children: [
          // Fixed Navigation bar at the top
          const NavBar(),
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              controller: scrollService.scrollController,
              child: Column(
                children: [
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
          ),
        ],
      ),
    );
  }
}
