import 'dart:async';

import 'package:flutter/material.dart';

import 'package:portfolio/core/utils/constants/app_colors.dart';

/// Cached network image with hover zoom effect
class HoverImage extends StatefulWidget {
  const HoverImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.borderRadius,
    this.enableZoom = false,
    this.fit = BoxFit.cover,
  });

  final String imageUrl;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final bool enableZoom;
  final BoxFit fit;

  @override
  State<HoverImage> createState() => _HoverImageState();
}

class _HoverImageState extends State<HoverImage> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: widget.enableZoom
          ? (_) => setState(() => _isHovered = true)
          : null,
      onExit: widget.enableZoom
          ? (_) => setState(() => _isHovered = false)
          : null,
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 700),
          child: Image.network(
            widget.imageUrl,
            height: widget.height,
            width: widget.width,
            fit: widget.fit,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: widget.height,
                width: widget.width,
                color: AppColors.cardLight,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                    color: AppColors.primary,
                    strokeWidth: 2,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: widget.height,
                width: widget.width,
                color: AppColors.cardLight,
                child: const Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: AppColors.textMuted,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Auto-sliding image carousel widget for showcasing project images
class AutoImageCarousel extends StatefulWidget {
  const AutoImageCarousel({
    super.key,
    required this.images,
    this.height,
    this.width,
    this.borderRadius,
    this.autoSlideDuration = const Duration(seconds: 4),
    this.fit = BoxFit.cover,
    this.enableHoverZoom = false,
    this.showIndicators = true,
    this.isAsset = true,
  });

  /// List of image paths (asset or network URLs)
  final List<String> images;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final Duration autoSlideDuration;
  final BoxFit fit;
  final bool enableHoverZoom;
  final bool showIndicators;
  final bool isAsset;

  @override
  State<AutoImageCarousel> createState() => _AutoImageCarouselState();
}

class _AutoImageCarouselState extends State<AutoImageCarousel> {
  late PageController _pageController;
  Timer? _autoSlideTimer;
  int _currentPage = 0;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  @override
  void didUpdateWidget(covariant AutoImageCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset carousel when images change
    if (oldWidget.images != widget.images) {
      _currentPage = 0;
      if (_pageController.hasClients) {
        _pageController.jumpToPage(0);
      }
      _startAutoSlide();
    }
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    if (widget.images.length <= 1) return;

    _autoSlideTimer = Timer.periodic(widget.autoSlideDuration, (timer) {
      if (!mounted || !_pageController.hasClients) return;

      final nextPage = (_currentPage + 1) % widget.images.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return _buildPlaceholder();
    }

    return MouseRegion(
      onEnter: widget.enableHoverZoom
          ? (_) => setState(() => _isHovered = true)
          : null,
      onExit: widget.enableHoverZoom
          ? (_) => setState(() => _isHovered = false)
          : null,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image carousel
              PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return AnimatedScale(
                    scale: _isHovered ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 700),
                    child: widget.isAsset
                        ? Image.asset(
                            widget.images[index],
                            fit: widget.fit,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildErrorWidget();
                            },
                          )
                        : Image.network(
                            widget.images[index],
                            fit: widget.fit,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return _buildLoadingWidget();
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return _buildErrorWidget();
                            },
                          ),
                  );
                },
              ),

              // Page indicators
              if (widget.showIndicators && widget.images.length > 1)
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: _buildPageIndicators(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.2),
            AppColors.purple.withValues(alpha: 0.2),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 48,
              color: AppColors.textMuted.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 12),
            Text(
              'No Images Available',
              style: TextStyle(
                color: AppColors.textMuted.withValues(alpha: 0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      color: AppColors.cardLight,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: AppColors.cardLight,
      child: const Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: AppColors.textMuted,
          size: 48,
        ),
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.images.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? Colors.white
                : Colors.white.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Avatar image widget
class AvatarImage extends StatelessWidget {
  const AvatarImage({super.key, required this.imageUrl, this.size = 32});

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: size,
            height: size,
            color: AppColors.cardLight,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            color: AppColors.cardLight,
            child: Icon(
              Icons.person,
              size: size * 0.6,
              color: AppColors.textMuted,
            ),
          );
        },
      ),
    );
  }
}
