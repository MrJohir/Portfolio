import 'package:portfolio/core/utils/constants/app_images.dart';

/// Project model for portfolio projects
class ProjectModel {
  const ProjectModel({
    required this.id,
    required this.category,
    required this.title,
    required this.descriptionPoints,
    required this.techStack,
    required this.images,
    this.isLive = false,
    this.storeUrl,
    this.githubUrl,
    this.isPlayStore = false,
    this.playStoreUrl,
    this.appStoreUrl,
  });

  final String id;
  final String category;
  final String title;
  final List<String> descriptionPoints;
  final List<String> techStack;
  final List<String> images;
  final bool isLive;
  final String? storeUrl;
  final String? githubUrl;
  final bool isPlayStore;
  final String? playStoreUrl;
  final String? appStoreUrl;

  /// Get store label based on isPlayStore flag
  String get storeLabel =>
      isPlayStore ? '🚀 Live on Play Store' : '🍎 Live on App Store';

  /// Get link button label
  String get linkLabel {
    if (!isLive) return 'View on GitHub';
    return isPlayStore ? 'View On Play Store' : 'View On App Store';
  }

  /// Get link URL
  String get linkUrl => isLive ? (storeUrl ?? '') : (githubUrl ?? '');

  /// Check if project is live on both stores
  bool get isOnBothStores =>
      playStoreUrl != null &&
      appStoreUrl != null &&
      playStoreUrl!.isNotEmpty &&
      appStoreUrl!.isNotEmpty;
}

/// Static list of all portfolio projects
class ProjectData {
  ProjectData._();

  static const String githubBaseUrl = 'https://github.com/MrJohir';

  static final List<ProjectModel> projects = [
    // 1. Deep Quran – Islamic Mobile Application (Production)
    ProjectModel(
      id: 'deep_quran',
      category: 'Islamic Mobile Application',
      title: 'Deep Quran',
      descriptionPoints: [
        'Developed a production-ready Islamic mobile application focused on Quran reading, memorization (Hafalan), and spiritual growth.',
        'Implemented complete Quran reading system with multiple modes, audio recitation, bookmarks, search, and Tafsir support.',
        'Built gamification features including missions, XP system, leaderboards, and achievement tracking to improve user engagement.',
        'Integrated Firebase Authentication, push notifications (FCM), and secure subscription-based payment gateway.',
      ],
      techStack: [
        'Flutter',
        'Dart',
        'GetX',
        'Firebase',
        'REST API',
        'sqflite',
        'FCM',
        'Payment Gateway',
      ],
      images: AppImages.deepQuranImages,
      isLive: true,
      storeUrl:
          'https://play.google.com/store/apps/details?id=com.deepquran.app',
      isPlayStore: true,
    ),
    // 2. ServiGo – Service Booking Platform (Production)
    ProjectModel(
      id: 'reparo',
      category: 'Service Booking Platform',
      title: 'Reparo',
      descriptionPoints: [
        'Built a scalable, subscription-based service marketplace connecting customers with professional service providers.',
        'Implemented end-to-end booking flow with real-time availability, location-based services, and role-based dashboards.',
        'Integrated secure payments using Stripe with subscription management and automated expiry handling.',
        'Developed AI-powered real-time chat and push notifications for seamless customer–provider communication.',
        'Integrated Google Maps for GPS-based location selection, geocoding, and live tracking.',
      ],
      techStack: [
        'Flutter',
        'Dart',
        'GetX',
        'Firebase (Auth, FCM)',
        'Stripe',
        'REST API',
        'WebSockets',
        'Google Maps',
      ],
      images: AppImages.reparoImages,
      isLive: true,
      storeUrl: 'https://apps.apple.com/us/app/reparo/id6756050921',
      isPlayStore: false,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.gentleman.app',
      appStoreUrl: 'https://apps.apple.com/us/app/reparo/id6756050921',
    ),
    // 3. MediConnect – Hospital Management Platform (NEW)
    ProjectModel(
      id: 'mediconnect',
      category: 'Hospital Management Platform',
      title: 'MediConnect',
      descriptionPoints: [
        'Built a multi-role healthcare mobile application supporting Doctors, Nurses, Clinics, and Patients.',
        'Implemented appointment booking, management, and real-time reminders.',
        'Developed real-time chat and push notifications using Firebase and WebSockets.',
        'Integrated video/audio consultations with Agora RTC.',
        'Applied MVC architecture with GetX for state management and business logic separation.',
        'Added bilingual support and responsive UI for seamless user experience.',
      ],
      techStack: [
        'Flutter',
        'Dart',
        'GetX',
        'Firebase (Auth, FCM)',
        'REST API',
        'WebSocket',
        'Agora RTC',
        'Secure Storage',
      ],
      images: AppImages.giomaxImages,
      isLive: false,
      githubUrl: '$githubBaseUrl/MediConnect',
    ),
    // 4. TradeBridge – Dual-Role E-Commerce Marketplace
    ProjectModel(
      id: 'trade_bridge',
      category: 'E-Commerce Marketplace',
      title: 'TradeBridge',
      descriptionPoints: [
        'Built a full-featured dual-role e-commerce platform supporting both buyer and seller workflows within a single application.',
        'Implemented complete shopping lifecycle including product discovery, cart, secure checkout, order tracking, returns, and refunds.',
        'Developed seller-centric features such as inventory management, subscription plans, promotions, and analytics dashboards.',
        'Integrated secure authentication with OTP, JWT-based session handling, and Firebase push notifications.',
      ],
      techStack: [
        'Flutter',
        'Dart',
        'GetX',
        'REST API',
        'Firebase (Auth, FCM, Analytics)',
        'JWT',
        'Shared Preferences',
        'SQLite',
        'Payment Gateway',
      ],
      images: AppImages.tradeBridgeImages,
      isLive: false,
      githubUrl: '$githubBaseUrl/Trade_Bridge',
    ),
    // 5. Medix – Medical Management System
    ProjectModel(
      id: 'medix',
      category: 'Medical Management System',
      title: 'Medix',
      descriptionPoints: [
        'Designed and developed a full-featured dual-role e-commerce marketplace enabling users to seamlessly operate as both buyers and sellers within a single platform.',
        'Built a production-grade medical management system for clinical documentation, SOP governance, and emergency workflows.',
        'Implemented role-based access (Trainee, Admin, Super Admin) with secure authentication and structured workflow control.',
        'Developed medical calculators and AI-assisted triage system to support real-time clinical decision-making.',
        'Designed offline-first draft management for reports and SOPs with reliable local persistence.',
      ],
      techStack: [
        'Flutter',
        'Dart',
        'GetX',
        'Firebase',
        'REST API',
        'Local Storage(Hive)',
        'AI Integration',
      ],
      images: AppImages.medixImages,
      isLive: false,
      githubUrl: githubBaseUrl,
    ),
    // 6. BrainGuard – Recovery & Mental Wellness Application
    ProjectModel(
      id: 'brain_guard',
      category: 'Mental Wellness App',
      title: 'BrainGuard',
      descriptionPoints: [
        'Developed a privacy-focused mental wellness and addiction recovery application with progress tracking and habit analytics.',
        'Implemented AI-powered coaching system using real-time WebSocket communication for 24/7 user support.',
        'Built core recovery tools including daily check-ins, panic coping mechanisms, journaling, meditation, and milestone tracking.',
        'Integrated community features with anonymous discussions and achievement-based motivation systems.',
        'Implemented biometric authentication, offline support, and secure subscription payments using Stripe.',
      ],
      techStack: [
        'Flutter',
        'Dart',
        'GetX',
        'REST API',
        'WebSockets',
        'Stripe',
        'Local Storage',
        'Biometric Auth',
      ],
      images: AppImages.brainGurdImages,
      isLive: false,
      githubUrl: '$githubBaseUrl/BrainGuard',
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
