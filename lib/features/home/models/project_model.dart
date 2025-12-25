import 'package:portfolio/core/utils/constants/app_images.dart';

/// Project model for portfolio projects
class ProjectModel {
  const ProjectModel({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.techStack,
    required this.images,
    this.isLive = false,
    this.storeUrl,
    this.githubUrl,
    this.isPlayStore = false,
  });

  final String id;
  final String category;
  final String title;
  final String description;
  final List<String> techStack;
  final List<String> images;
  final bool isLive;
  final String? storeUrl;
  final String? githubUrl;
  final bool isPlayStore;

  /// Get store label based on isPlayStore flag
  String get storeLabel =>
      isPlayStore ? '🚀 Live on Play Store' : '🍎 Live on App Store';

  /// Get link button label
  String get linkLabel => isLive ? 'View on Store' : 'View on GitHub';

  /// Get link URL
  String get linkUrl => isLive ? (storeUrl ?? '') : (githubUrl ?? '');
}

/// Static list of all portfolio projects
class ProjectData {
  ProjectData._();

  static const String githubBaseUrl = 'https://github.com/MrJohir';

  static final List<ProjectModel> projects = [
    ProjectModel(
      id: 'deep_quran',
      category: 'Islamic Mobile Application',
      title: 'Deep Quran',
      description:
          'Production-ready Islamic app with Quran reading, memorization (Hafalan), gamification features, XP system, leaderboards, and subscription-based payments.',
      techStack: ['Flutter', 'GetX', 'Firebase', 'REST API', 'SQLite'],
      images: AppImages.deepQuranImages,
      isLive: true,
      storeUrl:
          'https://play.google.com/store/apps/details?id=com.deepquran.app',
      isPlayStore: true,
    ),
    ProjectModel(
      id: 'reparo',
      category: 'Service Booking Platform',
      title: 'ServiGo (Reparo)',
      description:
          'A comprehensive service booking platform that connects customers with service providers for home repairs and maintenance.',
      techStack: ['Flutter', 'GetX', 'REST API', 'Payment Integration'],
      images: [],
      isLive: true,
      storeUrl: 'https://apps.apple.com/gb/app/reparo/id6756050921',
      isPlayStore: false,
    ),
    ProjectModel(
      id: 'trade_bridge',
      category: 'E-Commerce Marketplace',
      title: 'TradeBridge',
      description:
          'A modern e-commerce marketplace platform with seller and buyer features, real-time chat, and secure payment processing.',
      techStack: ['Flutter', 'GetX', 'Firebase', 'Stripe', 'REST API'],
      images: AppImages.tradeBridgeImages,
      isLive: false,
      githubUrl: githubBaseUrl,
    ),
    ProjectModel(
      id: 'medix',
      category: 'Medical Management System',
      title: 'Medix',
      description:
          'A comprehensive medical management system for clinics and hospitals with appointment scheduling, patient records, and billing.',
      techStack: ['Flutter', 'GetX', 'Firebase', 'REST API'],
      images: AppImages.medixImages,
      isLive: false,
      githubUrl: githubBaseUrl,
    ),
    ProjectModel(
      id: 'brain_guard',
      category: 'Mental Wellness App',
      title: 'BrainGuard',
      description:
          'A mental wellness and brain training app with cognitive exercises, mood tracking, and meditation features.',
      techStack: ['Flutter', 'GetX', 'Firebase', 'REST API'],
      images: [],
      isLive: false,
      githubUrl: githubBaseUrl,
    ),
  ];

  /// Get project by ID
  static ProjectModel getProjectById(String id) {
    return projects.firstWhere(
      (project) => project.id == id,
      orElse: () => projects.first,
    );
  }

  /// Get project by index
  static ProjectModel getProjectByIndex(int index) {
    if (index < 0 || index >= projects.length) {
      return projects.first;
    }
    return projects[index];
  }
}
