import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:portfolio/core/common/widgets/network_image.dart';
import 'package:portfolio/core/utils/constants/app_colors.dart';
import 'package:portfolio/core/utils/constants/app_strings.dart';
import 'package:portfolio/core/utils/responsive/responsive.dart';
import 'package:portfolio/core/utils/theme/app_text_styles.dart';
import 'package:portfolio/features/home/models/project_model.dart';

/// Recent work section with project list and featured project
class MyProjects extends StatefulWidget {
  const MyProjects({super.key});

  @override
  State<MyProjects> createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
  int _selectedProjectIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pre-cache first project's images into memory on initial load
    _precacheProjectImages(0);
  }

  void _precacheProjectImages(int index) {
    final project = ProjectData.getProjectByIndex(index);
    precacheNetworkImages(context, project.images);
  }

  void _onProjectSelected(int index) {
    if (_selectedProjectIndex != index) {
      setState(() {
        _selectedProjectIndex = index;
      });
      // Pre-cache selected project's images so carousel slides are instant
      _precacheProjectImages(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return ResponsiveContainer(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.myProjects, style: AppTextStyles.sectionTitle),
          const SizedBox(height: 32),
          isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      height: 550,
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Project list (fixed width with scroll)
          Container(
            width: 300,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              border: Border(
                right: BorderSide(
                  color: AppColors.textMuted.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: _buildProjectList(),
          ),

          // Image showcase (fixed width)
          SizedBox(
            width: 260,
            child: _ProjectImageShowcase(
              project: ProjectData.getProjectByIndex(_selectedProjectIndex),
            ),
          ),

          // Details card (flexible width)
          Expanded(
            child: _ProjectDetailsCard(
              project: ProjectData.getProjectByIndex(_selectedProjectIndex),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: ProjectData.projects.length,
      itemBuilder: (context, index) {
        final project = ProjectData.projects[index];
        final isSelected = _selectedProjectIndex == index;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => _onProjectSelected(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: isSelected
                    ? Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      )
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          project.title,
                          style: AppTextStyles.workTitle.copyWith(
                            fontSize: 14,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (project.isLive)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.green.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Live',
                            style: AppTextStyles.small.copyWith(
                              color: AppColors.green,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.category,
                    style: AppTextStyles.small.copyWith(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        SizedBox(height: 200, child: _buildProjectList()),
        const SizedBox(height: 24),
        SizedBox(
          height: 400,
          child: _ProjectImageShowcase(
            project: ProjectData.getProjectByIndex(_selectedProjectIndex),
          ),
        ),
        const SizedBox(height: 24),
        _ProjectDetailsCard(
          project: ProjectData.getProjectByIndex(_selectedProjectIndex),
        ),
      ],
    );
  }
}

/// Mobile screenshot showcase card with phone mockup
class _ProjectImageShowcase extends StatefulWidget {
  const _ProjectImageShowcase({required this.project});

  final ProjectModel project;

  @override
  State<_ProjectImageShowcase> createState() => _ProjectImageShowcaseState();
}

class _ProjectImageShowcaseState extends State<_ProjectImageShowcase> {
  final PageController _pageController = PageController();
  Timer? _autoSlideTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void didUpdateWidget(covariant _ProjectImageShowcase oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.project.id != widget.project.id) {
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
    if (widget.project.images.isEmpty) return;

    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted || !_pageController.hasClients) return;

      final nextPage = _currentPage + 1;
      // Loop infinitely: jump to first without animation when reaching end
      if (nextPage >= widget.project.images.length) {
        _pageController.jumpToPage(0);
      } else {
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasImages = widget.project.images.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.purple.withValues(alpha: 0.15),
            AppColors.blue.withValues(alpha: 0.1),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Grid pattern background
            Positioned.fill(child: CustomPaint(painter: _GridPatternPainter())),

            // Phone mockup with screenshots
            Center(
              child: Container(
                width: 180,
                height: 380,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      blurRadius: 25,
                      offset: const Offset(0, 15),
                    ),
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 30,
                      spreadRadius: -5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Stack(
                    children: [
                      // Phone screen content
                      Container(
                        padding: const EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: hasImages
                              ? PageView.builder(
                                  controller: _pageController,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentPage = index;
                                    });
                                  },
                                  itemCount: widget.project.images.length,
                                  itemBuilder: (context, index) {
                                    return AppNetworkImage(
                                      imageUrl: widget.project.images[index],
                                      fit: BoxFit.cover,
                                      width: 180,
                                      height: 380,
                                    );
                                  },
                                )
                              : _buildPlaceholder(),
                        ),
                      ),

                      // Home indicator
                      Positioned(
                        bottom: 6,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 80,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Page indicators
            if (hasImages && widget.project.images.length > 1)
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.project.images.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: _currentPage == index ? 16 : 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? AppColors.primary
                            : AppColors.primary.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(3),
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

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.cardLight,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 40,
              color: AppColors.textMuted.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 8),
            Text(
              'Coming Soon',
              style: AppTextStyles.small.copyWith(
                color: AppColors.textMuted,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Grid pattern painter for background
class _GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    const spacing = 25.0;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Project details card with description and tech stack
class _ProjectDetailsCard extends StatelessWidget {
  const _ProjectDetailsCard({required this.project});

  final ProjectModel project;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  /// Build description as bullet points
  Widget _buildDescriptionBullets(List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points.map((point) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 6, right: 8),
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  point,
                  style: AppTextStyles.body.copyWith(
                    height: 1.5,
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Store badge or GitHub badge
            _buildBadge(),
            const SizedBox(height: 14),

            // Project title
            Text(
              project.title,
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 22),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // Category
            Text(
              project.category,
              style: AppTextStyles.small.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 14),

            // Description (bullet points)
            _buildDescriptionBullets(project.descriptionPoints),
            const SizedBox(height: 16),

            // Tech stack
            Text(
              'Technologies',
              style: AppTextStyles.workTitle.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: project.techStack
                  .map((tech) => _TechTag(label: tech))
                  .toList(),
            ),
            const SizedBox(height: 16),

            // Action button
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge() {
    if (project.isLive) {
      if (project.isOnBothStores) {
        // Show both badges
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildStoreBadge('Live on Play Store', AppColors.green),
            _buildStoreBadge('Live on App Store', AppColors.blue),
          ],
        );
      } else {
        // Show single badge
        return _buildStoreBadge(
          project.isPlayStore ? 'Live on Play Store' : 'Live on App Store',
          project.isPlayStore ? AppColors.green : AppColors.blue,
        );
      }
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.textMuted.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColors.textMuted.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.code, size: 12, color: AppColors.textMuted),
            const SizedBox(width: 5),
            Text(
              'In Development',
              style: AppTextStyles.small.copyWith(
                color: AppColors.textMuted,
                fontWeight: FontWeight.w500,
                fontSize: 11,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildStoreBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.small.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    if (project.isOnBothStores) {
      // Show both buttons for dual-store projects
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _buildStoreButton(
            label: 'View on Play Store',
            url: project.playStoreUrl!,
            icon: Icons.shop,
            color: AppColors.green,
          ),
          _buildStoreButton(
            label: 'View on App Store',
            url: project.appStoreUrl!,
            icon: Icons.apple,
            color: AppColors.blue,
          ),
        ],
      );
    }

    // Single button - icon based on store type
    IconData buttonIcon;
    Color buttonColor;

    if (!project.isLive) {
      buttonIcon = Icons.code;
      buttonColor = AppColors.primary;
    } else if (project.isPlayStore) {
      buttonIcon = Icons.shop;
      buttonColor = AppColors.green;
    } else {
      buttonIcon = Icons.apple;
      buttonColor = AppColors.blue;
    }

    return _buildStoreButton(
      label: project.linkLabel,
      url: project.linkUrl,
      icon: buttonIcon,
      color: buttonColor,
    );
  }

  Widget _buildStoreButton({
    required String label,
    required String url,
    required IconData icon,
    required Color color,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(url),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: Colors.white),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.small.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tech tag widget for project technologies
class _TechTag extends StatelessWidget {
  const _TechTag({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: AppTextStyles.small.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
      ),
    );
  }
}
