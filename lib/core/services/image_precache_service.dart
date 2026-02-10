// import 'package:flutter/material.dart';
// import 'package:portfolio/core/utils/constants/app_images.dart';

// /// Service for precaching critical images on app startup
// /// This ensures faster image loading throughout the app
// class ImagePrecacheService {
//   ImagePrecacheService._();
//   static final ImagePrecacheService _instance = ImagePrecacheService._();
//   static ImagePrecacheService get instance => _instance;

//   bool _isPrecached = false;
//   bool get isPrecached => _isPrecached;

//   /// Critical images that should be loaded first (above the fold)
//   static const List<String> _criticalImages = [
//     AppImages.heroBg,
//     AppImages.profile,
//   ];

//   /// First set of showcase images (shown in hero carousel)
//   static List<String> get _primaryShowcaseImages {
//     // Only precache first 3 images from showcase
//     return AppImages.showcaseImages.take(3).toList();
//   }

//   /// Precache critical images for immediate display
//   /// Call this in your main widget's didChangeDependencies
//   Future<void> precacheCriticalImages(BuildContext context) async {
//     if (_isPrecached) return;

//     try {
//       // Precache hero background and profile first
//       final criticalFutures = _criticalImages.map((imagePath) {
//         return precacheImage(
//           AssetImage(imagePath),
//           context,
//           onError: (exception, stackTrace) {
//             debugPrint('Failed to precache: $imagePath');
//           },
//         );
//       }).toList();

//       // Wait for critical images
//       await Future.wait(criticalFutures);

//       // Then precache primary showcase images in background
//       for (final imagePath in _primaryShowcaseImages) {
//         if (context.mounted) {
//           precacheImage(AssetImage(imagePath), context, onError: (_, __) {});
//         }
//       }

//       _isPrecached = true;
//     } catch (e) {
//       debugPrint('Precache error: $e');
//     }
//   }

//   /// Precache images for a specific project when selected
//   Future<void> precacheProjectImages(
//     BuildContext context,
//     List<String> images,
//   ) async {
//     for (final imagePath in images) {
//       if (context.mounted) {
//         try {
//           await precacheImage(
//             AssetImage(imagePath),
//             context,
//             onError: (_, __) {},
//           );
//         } catch (_) {
//           // Ignore individual image errors
//         }
//       }
//     }
//   }

//   /// Clear precache flag (useful for hot reload during development)
//   void reset() {
//     _isPrecached = false;
//   }
// }

// /// Mixin to add image precaching capability to StatefulWidgets
// mixin ImagePrecacheMixin<T extends StatefulWidget> on State<T> {
//   bool _hasPreachedImages = false;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (!_hasPreachedImages) {
//       _hasPreachedImages = true;
//       ImagePrecacheService.instance.precacheCriticalImages(context);
//     }
//   }
// }

// /// Extension to easily precache a list of images
// extension ImagePrecacheExtension on List<String> {
//   Future<void> precacheAll(BuildContext context) async {
//     for (final path in this) {
//       if (context.mounted) {
//         try {
//           await precacheImage(AssetImage(path), context);
//         } catch (_) {}
//       }
//     }
//   }

//   /// Precache only first N images
//   Future<void> precacheFirst(BuildContext context, int count) async {
//     final toCache = take(count).toList();
//     for (final path in toCache) {
//       if (context.mounted) {
//         try {
//           await precacheImage(AssetImage(path), context);
//         } catch (_) {}
//       }
//     }
//   }
// }
