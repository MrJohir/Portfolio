import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/utils/constants/app_colors.dart';

/// Pre-cache a list of network images into memory so they load instantly.
/// Call this in [didChangeDependencies] or [initState]+[addPostFrameCallback].
Future<void> precacheNetworkImages(
  BuildContext context,
  List<String> urls,
) async {
  for (final url in urls) {
    if (!context.mounted) return;
    try {
      await precacheImage(CachedNetworkImageProvider(url), context);
    } catch (_) {
      // Ignore individual failures — image will still show shimmer on load
    }
  }
}

/// A clean wrapper around [CachedNetworkImage] with a subtle shimmer placeholder.
/// Used across the portfolio for all Cloudinary-hosted images.
///
/// Images that are already in memory cache will appear instantly (no shimmer).
class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
  });

  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      // If image is in memory cache → show instantly, no fade
      // If loading from network/disk → short fade-in
      fadeInDuration: const Duration(milliseconds: 200),
      fadeOutDuration: Duration.zero,
      // Use useOldImageOnUrlChange to prevent flash when URL hasn't really changed
      useOldImageOnUrlChange: true,
      placeholder: (_, __) => _ShimmerBox(width: width, height: height),
      errorWidget: (_, __, ___) =>
          _ErrorPlaceholder(width: width, height: height),
    );

    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }
}

/// A simple, subtle shimmer placeholder shown while the image loads.
class _ShimmerBox extends StatefulWidget {
  const _ShimmerBox({this.width, this.height});
  final double? width;
  final double? height;

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                AppColors.cardLight,
                AppColors.borderLight,
                AppColors.cardLight,
              ],
              stops: [
                (_animation.value - 0.3).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 0.3).clamp(0.0, 1.0),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Fallback widget shown when an image fails to load.
class _ErrorPlaceholder extends StatelessWidget {
  const _ErrorPlaceholder({this.width, this.height});
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppColors.cardLight,
      child: const Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: AppColors.textMuted,
          size: 32,
        ),
      ),
    );
  }
}
