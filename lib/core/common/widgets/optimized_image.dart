// import 'package:flutter/material.dart';
// import 'package:portfolio/core/utils/constants/app_colors.dart';

// /// Optimized image widget with shimmer loading effect and error handling
// /// This provides a professional loading experience for images
// class OptimizedImage extends StatefulWidget {
//   const OptimizedImage({
//     super.key,
//     required this.imagePath,
//     this.fit = BoxFit.cover,
//     this.width,
//     this.height,
//     this.borderRadius,
//     this.placeholder,
//     this.errorWidget,
//     this.enableShimmer = true,
//   });

//   final String imagePath;
//   final BoxFit fit;
//   final double? width;
//   final double? height;
//   final BorderRadius? borderRadius;
//   final Widget? placeholder;
//   final Widget? errorWidget;
//   final bool enableShimmer;

//   @override
//   State<OptimizedImage> createState() => _OptimizedImageState();
// }

// class _OptimizedImageState extends State<OptimizedImage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _shimmerController;
//   bool _isLoaded = false;
//   bool _hasError = false;

//   @override
//   void initState() {
//     super.initState();
//     _shimmerController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _shimmerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget imageWidget = Image.asset(
//       widget.imagePath,
//       fit: widget.fit,
//       width: widget.width,
//       height: widget.height,
//       cacheWidth: _getCacheWidth(),
//       cacheHeight: _getCacheHeight(),
//       gaplessPlayback: true,
//       frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
//         if (wasSynchronouslyLoaded || frame != null) {
//           // Image is loaded
//           if (!_isLoaded && mounted) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               if (mounted) setState(() => _isLoaded = true);
//             });
//           }
//           return AnimatedOpacity(
//             opacity: _isLoaded ? 1.0 : 0.0,
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeOut,
//             child: child,
//           );
//         }
//         // Still loading
//         return widget.enableShimmer
//             ? _buildShimmerPlaceholder()
//             : (widget.placeholder ?? _buildSimplePlaceholder());
//       },
//       errorBuilder: (context, error, stackTrace) {
//         if (!_hasError && mounted) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (mounted) setState(() => _hasError = true);
//           });
//         }
//         return widget.errorWidget ?? _buildErrorWidget();
//       },
//     );

//     // Apply border radius if provided
//     if (widget.borderRadius != null) {
//       imageWidget = ClipRRect(
//         borderRadius: widget.borderRadius!,
//         child: imageWidget,
//       );
//     }

//     return Stack(
//       fit: StackFit.passthrough,
//       children: [
//         // Show shimmer until loaded
//         if (!_isLoaded && !_hasError && widget.enableShimmer)
//           _buildShimmerPlaceholder(),
//         imageWidget,
//       ],
//     );
//   }

//   /// Calculate optimal cache width for memory efficiency
//   int? _getCacheWidth() {
//     if (widget.width != null) {
//       // Use 2x for retina displays, capped at reasonable size
//       return (widget.width! * 2).toInt().clamp(100, 800);
//     }
//     return 600; // Default cache width
//   }

//   /// Calculate optimal cache height for memory efficiency
//   int? _getCacheHeight() {
//     if (widget.height != null) {
//       return (widget.height! * 2).toInt().clamp(100, 1200);
//     }
//     return null;
//   }

//   Widget _buildShimmerPlaceholder() {
//     return AnimatedBuilder(
//       animation: _shimmerController,
//       builder: (context, child) {
//         return Container(
//           width: widget.width,
//           height: widget.height,
//           decoration: BoxDecoration(
//             borderRadius: widget.borderRadius,
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 AppColors.cardLight,
//                 AppColors.cardLight.withValues(alpha: 0.5),
//                 AppColors.cardLight,
//               ],
//               stops: [0.0, _shimmerController.value, 1.0],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSimplePlaceholder() {
//     return Container(
//       width: widget.width,
//       height: widget.height,
//       decoration: BoxDecoration(
//         color: AppColors.cardLight,
//         borderRadius: widget.borderRadius,
//       ),
//     );
//   }

//   Widget _buildErrorWidget() {
//     return Container(
//       width: widget.width,
//       height: widget.height,
//       decoration: BoxDecoration(
//         color: AppColors.cardLight,
//         borderRadius: widget.borderRadius,
//       ),
//       child: const Center(
//         child: Icon(
//           Icons.broken_image_outlined,
//           color: AppColors.textMuted,
//           size: 32,
//         ),
//       ),
//     );
//   }
// }

// /// Optimized network-style cached image for assets
// /// Uses memory caching for faster subsequent loads
// class CachedAssetImage extends StatelessWidget {
//   const CachedAssetImage({
//     super.key,
//     required this.imagePath,
//     this.fit = BoxFit.cover,
//     this.width,
//     this.height,
//     this.borderRadius,
//   });

//   final String imagePath;
//   final BoxFit fit;
//   final double? width;
//   final double? height;
//   final BorderRadius? borderRadius;

//   @override
//   Widget build(BuildContext context) {
//     return OptimizedImage(
//       imagePath: imagePath,
//       fit: fit,
//       width: width,
//       height: height,
//       borderRadius: borderRadius,
//     );
//   }
// }

// /// Phone mockup image showcase with optimized loading
// class PhoneMockupImage extends StatelessWidget {
//   const PhoneMockupImage({
//     super.key,
//     required this.imagePath,
//     this.width = 180,
//     this.height = 380,
//   });

//   final String imagePath;
//   final double width;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return OptimizedImage(
//       imagePath: imagePath,
//       fit: BoxFit.cover,
//       width: width,
//       height: height,
//       borderRadius: BorderRadius.circular(22),
//     );
//   }
// }
