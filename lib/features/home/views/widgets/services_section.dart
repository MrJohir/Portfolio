import 'package:flutter/material.dart';
import 'package:portfolio/core/utils/constants/app_colors.dart';
import 'package:portfolio/core/utils/responsive/responsive.dart';
import 'package:portfolio/core/utils/theme/app_text_styles.dart';

/// Services section with 4 service cards
class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    final services = [
      _ServiceData(
        icon: Icons.phone_android,
        iconColor: AppColors.blue,
        question: 'Need a production-ready mobile app?',
        title: 'Flutter App Development',
        features: [
          'Cross-platform iOS & Android apps',
          'Clean architecture & scalable codebase',
          'State management (GetX, BLoC, Provider)',
          'Play Store & App Store deployment',
        ],
        buttonText: 'Start Your Project',
      ),
      _ServiceData(
        icon: Icons.groups,
        iconColor: AppColors.purple,
        question: 'Looking for technical leadership?',
        title: 'Team Leadership',
        features: [
          'Sprint planning & task coordination',
          'Code reviews & best practices',
          'Architecture design & enforcement',
          'Team mentoring & skill development',
        ],
        buttonText: 'Discuss Leadership',
      ),
      _ServiceData(
        icon: Icons.api,
        iconColor: AppColors.orange,
        question: 'Need backend integration?',
        title: 'API & Real-time Systems',
        features: [
          'REST API integration',
          'WebSockets & Socket.IO',
          'Firebase services (Auth, FCM)',
          'Payment gateways (Stripe, SSLCommerz)',
        ],
        buttonText: 'Explore Integration',
      ),
      _ServiceData(
        icon: Icons.rocket_launch,
        iconColor: AppColors.green,
        question: 'Ready to launch your app?',
        title: 'App Store Deployment',
        features: [
          'Google Play Store publishing',
          'Apple App Store submission',
          'Store compliance & optimization',
          'Version management & updates',
        ],
        buttonText: 'Launch Your App',
      ),
    ];

    // Calculate card width based on screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = 24.0 * 2;
    final availableWidth = screenWidth - horizontalPadding;
    final cardSpacing = 24.0;

    // Desktop: 4 cards, Tablet: 2 cards, Mobile: 1 card
    final cardsPerRow = isDesktop ? 4 : (isTablet ? 2 : 1);
    final totalSpacing = cardSpacing * (cardsPerRow - 1);
    final cardWidth = (availableWidth - totalSpacing) / cardsPerRow;

    return ResponsiveContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Wrap(
        spacing: cardSpacing,
        runSpacing: cardSpacing,
        children: services
            .map(
              (service) => SizedBox(
                width: cardWidth,
                child: _ServiceCard(data: service),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ServiceData {
  const _ServiceData({
    required this.icon,
    required this.iconColor,
    required this.question,
    required this.title,
    required this.features,
    required this.buttonText,
  });

  final IconData icon;
  final Color iconColor;
  final String question;
  final String title;
  final List<String> features;
  final String buttonText;
}

/// Single service card
class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.data});
  final _ServiceData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: data.iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(data.icon, color: data.iconColor, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            data.question,
            style: AppTextStyles.small.copyWith(
              color: AppColors.textLight,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            data.title,
            style: AppTextStyles.workTitle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.features
                .map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: data.iconColor,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            feature,
                            style: AppTextStyles.small.copyWith(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
