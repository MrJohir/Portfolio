import 'package:flutter/material.dart';
import 'package:portfolio/core/utils/constants/app_colors.dart';
import 'package:portfolio/core/utils/constants/app_strings.dart';
import 'package:portfolio/core/utils/responsive/responsive.dart';
import 'package:portfolio/core/utils/theme/app_text_styles.dart';

/// Skills section with technical expertise
class SkillSection extends StatelessWidget {
  const SkillSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    final skillCategories = [
      _SkillCategoryData(
        title: 'Programming Languages',
        icon: Icons.code,
        iconColor: AppColors.blue,
        skills: ['Dart (OOP)', 'Java', 'C', 'C++'],
      ),
      _SkillCategoryData(
        title: 'Framework & Architecture',
        icon: Icons.architecture,
        iconColor: AppColors.purple,
        skills: [
          'Flutter SDK (Mobile & Web)',
          'MVC',
          'MVVM',
          'Modular Structure',
        ],
      ),
      _SkillCategoryData(
        title: 'State Management',
        icon: Icons.sync_alt,
        iconColor: AppColors.orange,
        skills: ['GetX', 'Provider', ' Riverpod'],
      ),
      _SkillCategoryData(
        title: 'Backend & APIs',
        icon: Icons.cloud,
        iconColor: AppColors.green,
        skills: [
          'REST APIs',
          'AI Integration',
          'Firebase Services',
          'WebSockets',
          'Socket.IO',
          'Google Maps',
        ],
      ),
      _SkillCategoryData(
        title: 'Local Storage',
        icon: Icons.storage,
        iconColor: AppColors.red,
        skills: [
          'sqflite',
          'Hive',
          'Flutter Secure Storage',
          'Shared Preferences',
          'Get Storage',
        ],
      ),
      _SkillCategoryData(
        title: 'Real-Time Communication',
        icon: Icons.chat,
        iconColor: AppColors.indigo,
        skills: [
          'Socket.IO (Chat)',
          'WebSockets',
          'Agora (Audio & Video Call)',
        ],
      ),
    ];

    return ResponsiveContainer(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
      child: Column(
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.skillsSectionTitle,
                      style: AppTextStyles.sectionTitle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.skillsSectionSubtitle,
                      style: AppTextStyles.bodyText,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isDesktop ? 32 : 0),

          // Skills Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : (isTablet ? 2 : 1),
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: isDesktop ? 2.2 : (isTablet ? 2.0 : 2.8),
            ),
            itemCount: skillCategories.length,
            itemBuilder: (context, index) =>
                _SkillCategoryCard(data: skillCategories[index]),
          ),
          const SizedBox(height: 32),

          // Additional Skills
          _AdditionalSkillsSection(),
        ],
      ),
    );
  }
}

class _SkillCategoryData {
  const _SkillCategoryData({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.skills,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final List<String> skills;
}

/// Skill category card
class _SkillCategoryCard extends StatelessWidget {
  const _SkillCategoryCard({required this.data});
  final _SkillCategoryData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: data.iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(data.icon, color: data.iconColor, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  data.title,
                  style: AppTextStyles.workTitle.copyWith(fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: data.skills
                    .map(
                      (skill) =>
                          _SkillChip(label: skill, color: data.iconColor),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Skill chip widget
class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: AppTextStyles.small.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// Additional skills section
class _AdditionalSkillsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    final additionalSkills = [
      _AdditionalSkillData(
        category: 'Authentication',
        skills: 'Firebase Auth, Google Login, Facebook Login, Biometric Auth',
        icon: Icons.fingerprint,
      ),
      _AdditionalSkillData(
        category: 'Payment Integration',
        skills: 'Stripe, SSLCommerz, Subscription Management',
        icon: Icons.payment,
      ),
      _AdditionalSkillData(
        category: 'Maps & Location',
        skills: 'Google Maps, GPS Location, Geocoding, Live Tracking',
        icon: Icons.location_on,
      ),
      _AdditionalSkillData(
        category: 'AI Features',
        skills: 'AI API Integration, AI Coach, Smart Recommendations',
        icon: Icons.psychology,
      ),
      _AdditionalSkillData(
        category: 'Tools & Platforms',
        skills: 'Android Studio, VS Code, Xcode, Git, Postman',
        icon: Icons.build,
      ),
      _AdditionalSkillData(
        category: 'Deployment',
        skills: 'Google Play Store, Apple App Store, Version Management',
        icon: Icons.cloud_upload,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Additional Expertise', style: AppTextStyles.cardTitle),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: additionalSkills
                .map(
                  (skill) => SizedBox(
                    width: isDesktop ? 320 : double.infinity,
                    child: _AdditionalSkillItem(data: skill),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _AdditionalSkillData {
  const _AdditionalSkillData({
    required this.category,
    required this.skills,
    required this.icon,
  });

  final String category;
  final String skills;
  final IconData icon;
}

class _AdditionalSkillItem extends StatelessWidget {
  const _AdditionalSkillItem({required this.data});
  final _AdditionalSkillData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(data.icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.category,
                style: AppTextStyles.workTitle.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 2),
              Text(data.skills, style: AppTextStyles.small),
            ],
          ),
        ),
      ],
    );
  }
}
