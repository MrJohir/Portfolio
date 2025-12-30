# 📱 Portfolio - Professional Showcase App

A modern, responsive Flutter portfolio application showcasing professional work, projects, and services with smooth scrolling navigation and interactive sections.

## 🎯 Project Overview

**Portfolio** is a full-featured personal portfolio application built with Flutter. It demonstrates professional projects, skills, and services with a modern UI design. The app is fully responsive and works seamlessly across mobile, tablet, and web platforms.

**Developer:** Md. Johirul Islam

## ✨ Key Features

- 🏠 **Hero Section** - Eye-catching landing section with call-to-action
- 👤 **About Section** - Professional introduction with 3 feature cards
- 🚀 **Project Showcase** - Display of recent work and portfolio projects:
  - Brain Gurd
  - Deep Quran
  - Giomax
  - Medix
  - Reparo
  - Roman
  - Trade Bridge
- 💡 **Skills Section** - Display of technical expertise and competencies
- 🔄 **Process Section** - 6-step workflow/process visualization
- 🛠️ **Services Section** - Professional services offered
- 📧 **Contact Section** - Interactive footer with contact form
- 🎨 **Responsive Design** - Optimized for mobile, tablet, and desktop views
- 🌓 **Theme Support** - Light and dark theme modes
- ✨ **Smooth Scrolling** - Seamless navigation between sections
- 🎯 **Hover Effects** - Interactive hover states for enhanced UX

## 📁 Project Structure

```
lib/
├── main.dart                    # Application entry point
├── core/
│   ├── common/
│   │   └── widgets/            # Reusable UI components
│   │       ├── nav_bar.dart       # Navigation bar
│   │       ├── buttons.dart       # Button components
│   │       └── hover_image.dart   # Hover effect widget
│   ├── services/
│   │   └── scroll_service.dart    # Scroll management service
│   ├── utils/
│   │   ├── constants/          # App constants and configuration
│   │   ├── helpers/            # Helper utilities
│   │   ├── responsive/         # Responsive design helpers
│   │   └── theme/              # Theme configuration
│   └── utils/
│       └── theme/
│           └── app_theme.dart    # Light & dark theme definitions
├── features/
│   └── home/
│       └── views/
│           ├── screens/
│           │   └── home_page.dart      # Main portfolio page
│           └── widgets/          # Feature-specific widgets
│               ├── hero_section.dart
│               ├── about_section.dart
│               ├── my_projects_section.dart
│               ├── skill_section.dart
│               ├── process_section.dart
│               ├── services_section.dart
│               ├── footer_section.dart
│               └── testimonials_section.dart
└── assets/                     # Image assets for projects
    ├── brain_gurd/
    ├── deep_quran/
    ├── giomax/
    ├── medix/
    ├── reparo/
    ├── roman/
    ├── trade_bridge/
    ├── bg.png                 # Background image
    └── profile.jpeg           # Profile photo
```

## 🛠️ Technology Stack

- **Framework:** Flutter 3.9.2+
- **Language:** Dart 3.9.2+
- **Package Management:** pub.dev

### Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_screenutil` | ^5.9.3 | Responsive sizing utilities |
| `google_fonts` | ^6.3.3 | Custom fonts |
| `url_launcher` | ^6.3.2 | Open URLs and links |
| `http` | ^1.6.0 | HTTP requests |
| `cupertino_icons` | ^1.0.8 | iOS-style icons |

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.9.2 or higher
- Dart SDK 3.9.2 or higher
- An IDE (VS Code, Android Studio, or Xcode)

### Installation

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd portfolio
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   # Run on default device
   flutter run

   # Run on specific device
   flutter run -d <device-id>
   
   # Run on web
   flutter run -d web
   ```

4. **Build for release:**
   ```bash
   # Android
   flutter build apk --release
   
   # iOS
   flutter build ios --release
   
   # Web (for Netlify deployment)
   flutter build web --release
   ```

## 🌐 Netlify Deployment Guide

### Method 1: Drag & Drop Deployment (Recommended for Quick Deploy)

1. **Build the web version:**
   ```bash
   flutter clean
   flutter build web --release
   ```

2. **Locate the build folder:**
   - After successful build, find the `build/web` folder in your project directory
   - This folder contains all the static files needed for deployment

3. **Deploy to Netlify:**
   - Go to [Netlify](https://www.netlify.com/)
   - Login or create an account
   - Click "Add new site" → "Deploy manually"
   - **Drag and drop the entire `build/web` folder** (not the project root)
   - Wait for deployment to complete
   - Your site will be live at: `https://random-name.netlify.app`

4. **Optional - Custom domain:**
   - In Netlify dashboard, go to "Domain settings"
   - Click "Add custom domain" to use your own domain

### Method 2: Git-based Continuous Deployment

1. **Push your code to GitHub/GitLab/Bitbucket**

2. **Connect to Netlify:**
   - Go to Netlify Dashboard
   - Click "Add new site" → "Import an existing project"
   - Connect your Git provider
   - Select your repository

3. **Configure build settings:**
   - Build command: `flutter build web --release`
   - Publish directory: `build/web`
   - Netlify will use the `netlify.toml` file automatically

4. **Deploy:**
   - Netlify will automatically build and deploy
   - Future commits will trigger automatic deployments

### Important Files for Netlify

This project includes:
- ✅ `web/_redirects` - Handles SPA routing correctly
- ✅ `netlify.toml` - Build configuration (for Git deployment)
- ✅ Optimized `web/index.html` - SEO meta tags

### Troubleshooting Netlify Deployment

**Build fails?**
- Make sure Flutter SDK is compatible (3.9.2+)
- Use `flutter build web --release --verbose` to see detailed errors

**404 errors on refresh?**
- The `_redirects` file should fix this
- Make sure `web/_redirects` is in your build folder

**Assets not loading?**
- Check `pubspec.yaml` asset paths
- Rebuild: `flutter clean && flutter build web --release`

**Site is slow?**
- Enable Netlify's asset optimization in dashboard
- Use `--web-renderer canvaskit` or `--web-renderer html` based on your needs:
  ```bash
  flutter build web --release --web-renderer html
  ```

## 📋 Available Scripts

```bash
# Get dependencies
flutter pub get

# Clean build
flutter clean && flutter pub get

# Analyze code
flutter analyze

# Format code
dart format .

# Run tests
flutter test

# Run on specific device
flutter devices              # List available devices
flutter run -d <device-id>
```

## 🎨 Architecture & Design

### Design Pattern: MVC
- **Model:** Data classes and API models
- **View:** UI widgets and screens
- **Controller:** Business logic and state management

### Responsive Design
- Mobile-first approach
- Adaptive layouts for all screen sizes
- Touch and hover interactions support

### Theme System
- **Light Theme:** Professional light color scheme
- **Dark Theme:** Eye-friendly dark color scheme
- Easy theme switching support

## 📱 Supported Platforms

- ✅ **iOS** - iPhone and iPad
- ✅ **Android** - Phone and Tablet
**Netlify deployment issues?**
- Only upload the `build/web` folder, not the entire project
- Make sure to run `flutter build web --release` first
- Check browser console for errors

---

**Last Updated:** December 2025  
**Flutter Version:** 3.9.2+  
**Status:** Active Development  
**Live Demo:** [Deploy on Netlify](https://www.netlify.com/)
### Navigation Bar
Sticky navigation bar with links to all sections:
- Home
- About
- Projects
- Skills
- Services
- Contact

### Scroll Service
Manages smooth scrolling between sections with animated scroll navigation.

### Responsive Helper
Provides breakpoints for responsive design:
- Mobile: < 600px
- Tablet: 600px - 1024px
- Desktop: > 1024px

## 🎯 Main Sections Explained

1. **Hero Section** - Welcome banner with profile introduction
2. **About Section** - 3-card feature showcase with highlights
3. **Projects Section** - Portfolio of 7 featured projects
4. **Skills Section** - Technical skills and expertise
5. **Process Section** - Step-by-step workflow visualization
6. **Services Section** - Offered professional services
7. **Contact Section** - Footer with contact form

## 📧 Contact & Links

For more information, visit or contact:
- **Name:** Md. Johirul Islam
- **Links:** Social media and contact methods in app footer

## 📄 License

This project is private and not published to pub.dev. Modify the `pubspec.yaml` file if you wish to publish.

## 🤝 Contributing

This is a personal portfolio project. For modifications or suggestions, please contact the developer directly.

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/)
- [Flutter Community](https://flutter.dev/community)

## ⚡ Performance Tips

- Use `flutter run --release` for production testing
- Enable profile mode: `flutter run --profile`
- Monitor performance with DevTools: `flutter pub global run devtools`

## 🐛 Troubleshooting

**App not running?**
```bash
flutter clean
flutter pub get
flutter run
```

**Build issues?**
- Update Flutter: `flutter upgrade`
- Check SDK constraints: `flutter doctor`
- Clear build cache: `flutter clean`

---

**Last Updated:** December 2025  
**Flutter Version:** 3.9.2+  
**Status:** Active Development
