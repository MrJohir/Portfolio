import 'package:flutter/material.dart';
import 'package:portfolio/core/utils/constants/app_colors.dart';
import 'package:portfolio/core/utils/constants/app_strings.dart';
import 'package:portfolio/core/utils/responsive/responsive.dart';
import 'package:portfolio/core/utils/theme/app_text_styles.dart';

/// Process section with 6 steps
class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return ResponsiveContainer(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 10 : 20,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.processTitle, style: AppTextStyles.sectionTitle),
          const SizedBox(height: 8),
          Text(AppStrings.processSubtitle, style: AppTextStyles.body),
          const SizedBox(height: 32),
          const _ProcessStepsGrid(),
          // const SizedBox(height: 24),
          // const _ActionButtons(),
        ],
      ),
    );
  }
}

/// Grid of process steps
class _ProcessStepsGrid extends StatelessWidget {
  const _ProcessStepsGrid();

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    const steps = [
      _ProcessStepData(
        icon: Icons.search,
        iconColor: AppColors.primary,
        title: AppStrings.discovery,
        description: 'Understanding requirements, goals, and project scope',
        number: '01',
      ),
      _ProcessStepData(
        icon: Icons.architecture,
        iconColor: AppColors.orange,
        title: AppStrings.planning,
        description: 'Architecture design, milestones, and sprint planning',
        number: '02',
      ),
      _ProcessStepData(
        icon: Icons.design_services,
        iconColor: AppColors.purple,
        title: AppStrings.design,
        description: 'UI/UX design, responsive layouts, and prototyping',
        number: '03',
      ),
      _ProcessStepData(
        icon: Icons.code,
        iconColor: AppColors.blue,
        title: AppStrings.build,
        description: 'Clean code development with GetX/BLoC patterns',
        number: '04',
      ),
      _ProcessStepData(
        icon: Icons.bug_report,
        iconColor: AppColors.red,
        title: AppStrings.test,
        description: 'QA testing, bug fixes, and performance optimization',
        number: '05',
      ),
      _ProcessStepData(
        icon: Icons.rocket_launch,
        iconColor: AppColors.green,
        title: AppStrings.launch,
        description: 'Play Store & App Store deployment with support',
        number: '06',
      ),
    ];

    // Calculate card width based on screen size
    final screenWidth = MediaQuery.of(context).size.width;
    // Match the horizontal padding from ResponsiveContainer (10 * 2)
    final horizontalPadding = 10.0 * 2;
    final availableWidth = screenWidth - horizontalPadding;
    final cardSpacing = 16.0;

    // Desktop: 6 cards, Tablet: 3 cards, Mobile: 2 cards
    final cardsPerRow = isDesktop ? 6 : (isTablet ? 3 : 2);
    final totalSpacing = cardSpacing * (cardsPerRow - 1);
    // Ensure card width is never negative
    final cardWidth = ((availableWidth - totalSpacing) / cardsPerRow).clamp(
      100.0,
      double.infinity,
    );

    return Wrap(
      spacing: cardSpacing,
      runSpacing: cardSpacing,
      children: steps
          .map(
            (step) => SizedBox(
              width: cardWidth,
              child: _ProcessStepCard(data: step),
            ),
          )
          .toList(),
    );
  }
}

class _ProcessStepData {
  const _ProcessStepData({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.number,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String number;
}

/// Single process step card
class _ProcessStepCard extends StatelessWidget {
  const _ProcessStepCard({required this.data});
  final _ProcessStepData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(data.icon, color: data.iconColor, size: 22),
              Text(
                data.number,
                style: AppTextStyles.small.copyWith(color: AppColors.textLight),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            data.title,
            style: AppTextStyles.workTitle.copyWith(fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            data.description,
            style: AppTextStyles.small.copyWith(height: 1.4, fontSize: 14),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
