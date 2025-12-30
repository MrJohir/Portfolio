import 'package:flutter/material.dart';

import 'package:portfolio/core/common/widgets/optimized_image.dart';
import 'package:portfolio/core/utils/constants/app_colors.dart';
import 'package:portfolio/core/utils/constants/app_images.dart';
import 'package:portfolio/core/utils/constants/app_strings.dart';
import 'package:portfolio/core/utils/responsive/responsive.dart';
import 'package:portfolio/core/utils/theme/app_text_styles.dart';

/// About section with portrait, description, and work experience
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return ResponsiveContainer(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: isDesktop
          ? _buildDesktopLayout()
          : isTablet
          ? _buildTabletLayout()
          : _buildMobileLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: SizedBox(height: 500, child: _PortraitCard())),
        const SizedBox(width: 32),
        Expanded(child: _DescriptionCard()),
        const SizedBox(width: 32),
        Expanded(child: _ExperienceCard()),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(
                child: SizedBox(height: 400, child: _PortraitCard()),
              ),
              const SizedBox(width: 24),
              Expanded(child: _DescriptionCard()),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _ExperienceCard(),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        const SizedBox(height: 400, child: _PortraitCard()),
        const SizedBox(height: 24),
        _DescriptionCard(),
        const SizedBox(height: 24),
        _ExperienceCard(),
      ],
    );
  }
}

/// Portrait card with image and overlay text
class _PortraitCard extends StatelessWidget {
  const _PortraitCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 400),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: OptimizedImage(
          imagePath: AppImages.profile,
          fit: BoxFit.cover,
          // Limit cache size for large profile image
          width: 400,
          height: 500,
          errorWidget: Container(
            color: AppColors.cardLight,
            child: const Center(
              child: Icon(Icons.person, size: 64, color: AppColors.textMuted),
            ),
          ),
        ),
      ),
    );
  }
}

/// Hover link with arrow
class _HoverLink extends StatefulWidget {
  const _HoverLink({required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  State<_HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<_HoverLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: AppTextStyles.small.copyWith(
                color: Colors.white.withValues(alpha: _isHovered ? 1.0 : 0.8),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_forward,
              size: 14,
              color: Colors.white.withValues(alpha: _isHovered ? 1.0 : 0.8),
            ),
          ],
        ),
      ),
    );
  }
}

/// Description card with about text
class _DescriptionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppStrings.aboutTitle, style: AppTextStyles.sectionTitle),
            const SizedBox(height: 24),
            Text(
              AppStrings.aboutPara1,
              style: AppTextStyles.body.copyWith(height: 1.7),
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.aboutPara2,
              style: AppTextStyles.body.copyWith(height: 1.7),
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.aboutPara3,
              style: AppTextStyles.body.copyWith(height: 1.7),
            ),
          ],
        ),
      ),
    );
  }
}

/// Work experience card with timeline
class _ExperienceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.workExperience, style: AppTextStyles.cardTitle),
          const SizedBox(height: 24),
          const _ExperienceItem(
            title: 'Flutter Developer | Team Lead',
            company: 'Softvency IT Limited',
            period: 'Oct 2024 - Present',
            isActive: true,
          ),
          const SizedBox(height: 32),
          // Education Section
          Text(AppStrings.education, style: AppTextStyles.cardTitle),
          const SizedBox(height: 16),
          const _EducationItem(
            degree: 'BSc in Computer Science & Engineering',
            institution: 'Sonargaon University',
            year: '2024',
            grade: 'CGPA: 3.47 / 4.00',
          ),
          const SizedBox(height: 12),
          const _EducationItem(
            degree: 'Higher Secondary Certificate (Science)',
            institution: 'Dinajpur Board',
            year: '2020',
            grade: 'GPA: 4.08 / 5.00',
          ),
          const SizedBox(height: 24),
          // Certifications
          Text(AppStrings.certifications, style: AppTextStyles.cardTitle),
          const SizedBox(height: 16),
          _CertificationItem(title: AppStrings.certification1),
          const SizedBox(height: 8),
          _CertificationItem(title: AppStrings.certification2),
        ],
      ),
    );
  }
}

/// Education item widget
class _EducationItem extends StatelessWidget {
  const _EducationItem({
    required this.degree,
    required this.institution,
    required this.year,
    required this.grade,
  });

  final String degree;
  final String institution;
  final String year;
  final String grade;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(degree, style: AppTextStyles.workTitle)),
              Text(year, style: AppTextStyles.primaryAccent),
            ],
          ),
          const SizedBox(height: 4),
          Text(institution, style: AppTextStyles.small),
          const SizedBox(height: 2),
          Text(
            grade,
            style: AppTextStyles.small.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Certification item widget
class _CertificationItem extends StatelessWidget {
  const _CertificationItem({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.verified, color: AppColors.primary, size: 18),
        const SizedBox(width: 8),
        Expanded(child: Text(title, style: AppTextStyles.small)),
      ],
    );
  }
}

/// Single experience item in timeline
class _ExperienceItem extends StatelessWidget {
  const _ExperienceItem({
    required this.title,
    required this.company,
    required this.period,
    this.isActive = false,
  });

  final String title;
  final String company;
  final String period;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: isActive ? AppColors.primary : AppColors.borderLight,
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title, style: AppTextStyles.workTitle)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : AppColors.textLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isActive ? 'Current' : period,
                  style: AppTextStyles.small.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(company, style: AppTextStyles.small),
          const SizedBox(height: 4),
          Text(period, style: AppTextStyles.primaryAccent),
        ],
      ),
    );
  }
}
