import 'package:flutter/material.dart';

import 'package:portfolio/core/services/scroll_service.dart';
import 'package:portfolio/core/utils/constants/app_colors.dart';
import 'package:portfolio/core/utils/constants/app_strings.dart';
import 'package:portfolio/core/utils/responsive/responsive.dart';
import 'package:portfolio/core/utils/theme/app_text_styles.dart';

/// Navigation bar widget matching HTML design
class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return ResponsiveContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          _buildLogo(),
          // Nav links (desktop only)
          if (isDesktop) _buildNavLinks(),
          // Hire Me button
          _buildHireButton(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.code, color: AppColors.primary, size: 24),
        const SizedBox(width: 8),
        Text(AppStrings.fullName, style: AppTextStyles.brandName),
      ],
    );
  }

  Widget _buildNavLinks() {
    final scrollService = ScrollService.instance;

    final navItems = [
      _NavItem(text: AppStrings.home, onTap: scrollService.scrollToHome),
      _NavItem(text: AppStrings.about, onTap: scrollService.scrollToAbout),
      _NavItem(text: AppStrings.skills, onTap: scrollService.scrollToSkills),
      _NavItem(
        text: AppStrings.projects,
        onTap: scrollService.scrollToProjects,
      ),
      _NavItem(text: AppStrings.contact, onTap: scrollService.scrollToContact),
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: navItems
          .map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _NavLink(text: item.text, onTap: item.onTap),
            ),
          )
          .toList(),
    );
  }

  Widget _buildHireButton() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => ScrollService.instance.scrollToContact(),
          borderRadius: BorderRadius.circular(100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Text(
              AppStrings.hireMe,
              style: AppTextStyles.button.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}

/// Navigation item data model
class _NavItem {
  const _NavItem({required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: AppTextStyles.navLink.copyWith(
            color: _isHovered ? AppColors.primary : AppColors.textSecondary,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}
