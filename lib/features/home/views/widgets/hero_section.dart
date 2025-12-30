import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portfolio/core/common/widgets/buttons.dart';
import 'package:portfolio/core/services/platform_service.dart';
import 'package:portfolio/core/utils/constants/app_colors.dart';
import 'package:portfolio/core/utils/constants/app_images.dart';
import 'package:portfolio/core/utils/constants/app_strings.dart';
import 'package:portfolio/core/utils/helpers/url_launcher_helper.dart';
import 'package:portfolio/core/utils/responsive/responsive.dart';
import 'package:portfolio/core/utils/theme/app_text_styles.dart';

/// Hero section matching HTML design
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return ResponsiveContainer(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: isDesktop ? 48 : 24,
      ),
      child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _buildContent()),
        const SizedBox(width: 48),
        Expanded(child: _buildImage()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [_buildContent(), const SizedBox(height: 48), _buildImage()],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(AppStrings.heroTitle, style: AppTextStyles.heroTitle),
        const SizedBox(height: 24),
        // Subtitle
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 512),
          child: Text(AppStrings.heroSubtitle, style: AppTextStyles.subtitle),
        ),
        const SizedBox(height: 24),
        // Buttons
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            PrimaryButton(
              text: AppStrings.exploreGithub,
              onPressed: () => UrlLauncherHelper.launchGitHub('MrJohir'),
            ),
            // SecondaryButton(text: AppStrings.downloadProcess, onPressed: () {}),
            SmallButton(
              text: AppStrings.donwloadCV,
              icon: Icons.download,
              onPressed: downloadCV,
              isPrimary: false,
            ),
          ],
        ),
        const SizedBox(height: 32),
        // Technologies section
        _buildTechnologiesSection(),
      ],
    );
  }

  Widget _buildTechnologiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.technologiesWorkedWith.toUpperCase(),
          style: AppTextStyles.label,
        ),
        const SizedBox(height: 16),
        _TechLogos(),
      ],
    );
  }

  Widget _buildImage() {
    return const _HeroImageShowcase();
  }
}

/// Hero image showcase with background and floating mobile screenshots
class _HeroImageShowcase extends StatefulWidget {
  const _HeroImageShowcase();

  @override
  State<_HeroImageShowcase> createState() => _HeroImageShowcaseState();
}

class _HeroImageShowcaseState extends State<_HeroImageShowcase>
    with WidgetsBindingObserver {
  late final PageController _pageController;
  Timer? _autoSlideTimer;
  int _currentPage = 0;

  /// Get showcase images from AppImages constants
  List<String> get _showcaseImages => AppImages.showcaseImages;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _pageController = PageController();
    // Delay starting auto slide to ensure widget is fully built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _startAutoSlide();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache images safely
    _precacheImages();
  }

  void _precacheImages() {
    if (!mounted) return;
    try {
      precacheImage(const AssetImage(AppImages.heroBg), context);
      for (final image in _showcaseImages) {
        if (!mounted) return;
        precacheImage(AssetImage(image), context);
      }
    } catch (_) {
      // Ignore precache errors during hot restart
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Pause timer when app is not visible
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _stopAutoSlide();
    } else if (state == AppLifecycleState.resumed) {
      _startAutoSlide();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopAutoSlide();
    _pageController.dispose();
    super.dispose();
  }

  void _stopAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = null;
  }

  void _startAutoSlide() {
    _stopAutoSlide();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _slideToNextPage();
    });
  }

  void _slideToNextPage() {
    // Safety checks
    if (!mounted) {
      _stopAutoSlide();
      return;
    }

    try {
      if (!_pageController.hasClients) return;

      final nextPage = _currentPage + 1;
      if (nextPage >= _showcaseImages.length) {
        _pageController.jumpToPage(0);
      } else {
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    } catch (_) {
      // Ignore errors during hot restart/dispose
      _stopAutoSlide();
    }
  }

  void _onPageChanged(int index) {
    if (mounted) {
      setState(() => _currentPage = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background image - precached for faster loading
            Positioned.fill(
              child: Image.asset(
                AppImages.heroBg,
                fit: BoxFit.cover,
                gaplessPlayback: true,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withValues(alpha: 0.15),
                          AppColors.purple.withValues(alpha: 0.2),
                          AppColors.blue.withValues(alpha: 0.15),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Floating mobile phone mockup with screenshots
            Center(
              child: Container(
                width: 220,
                height: 450,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 20),
                    ),
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 40,
                      spreadRadius: -5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        itemCount: _showcaseImages.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            _showcaseImages[index],
                            fit: BoxFit.cover,
                            gaplessPlayback: true,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.cardLight,
                                child: const Center(
                                  child: Icon(
                                    Icons.broken_image_outlined,
                                    color: AppColors.textMuted,
                                    size: 32,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechLogos extends StatefulWidget {
  @override
  State<_TechLogos> createState() => _TechLogosState();
}

class _TechLogosState extends State<_TechLogos> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _isHovered ? 1.0 : 0.8,
        child: Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            _TechBadge(label: 'Dart', color: AppColors.blue),
            _TechBadge(label: 'Flutter', color: AppColors.blue),
            _TechBadge(label: 'AI Integration', color: AppColors.orange),
            _TechBadge(label: 'Firebase', color: AppColors.orange),
            _TechBadge(label: 'GetX', color: AppColors.purple),
            _TechBadge(label: 'Provider', color: AppColors.purple),
            _TechBadge(label: 'Riverpod', color: AppColors.purple),

            _TechBadge(label: 'REST API', color: AppColors.green),
            _TechBadge(label: 'WebSockets', color: AppColors.green),
            _TechBadge(label: 'Socket.IO', color: AppColors.green),
            _TechBadge(label: 'Agora', color: AppColors.green),
            _TechBadge(label: 'Google Maps', color: AppColors.green),
            _TechBadge(label: 'Local Storage', color: AppColors.red),
            _TechBadge(label: 'Deployment', color: AppColors.red),
          ],
        ),
      ),
    );
  }
}

class _TechBadge extends StatelessWidget {
  const _TechBadge({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: AppTextStyles.small.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
