import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/core/common/widgets/buttons.dart';
import 'package:portfolio/core/services/emailjs_service.dart';
import 'package:portfolio/core/services/scroll_service.dart';
import 'package:portfolio/core/utils/constants/app_colors.dart';
import 'package:portfolio/core/utils/constants/app_strings.dart';
import 'package:portfolio/core/utils/responsive/responsive.dart';
import 'package:portfolio/core/utils/theme/app_text_styles.dart';

/// Footer section with contact form and links
class FooterSection extends StatefulWidget {
  const FooterSection({super.key});

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      // Send email using EmailJS
      final result = await EmailJSService.instance.sendEmail(
        fromName: _nameController.text,
        fromEmail: _emailController.text,
        subject: _subjectController.text,
        message: _messageController.text,
      );

      setState(() => _isLoading = false);

      if (result.isSuccess) {
        // Clear form on success
        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: result.isSuccess
                ? AppColors.primary
                : AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      color: AppColors.backgroundDark,
      child: ResponsiveContainer(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            // Main Footer Content
            isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Contact Form
                      Expanded(
                        flex: 2,
                        child: _ContactForm(
                          formKey: _formKey,
                          nameController: _nameController,
                          emailController: _emailController,
                          subjectController: _subjectController,
                          messageController: _messageController,
                          onSubmit: _submitForm,
                          isLoading: _isLoading,
                        ),
                      ),
                      const SizedBox(width: 64),
                      // Links Section
                      Expanded(
                        flex: 3,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _QuickLinks(onTap: _launchUrl)),
                            Expanded(child: _ServicesLinks(onTap: _launchUrl)),
                            Expanded(child: _ConnectSection(onTap: _launchUrl)),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      _ContactForm(
                        formKey: _formKey,
                        nameController: _nameController,
                        emailController: _emailController,
                        subjectController: _subjectController,
                        messageController: _messageController,
                        onSubmit: _submitForm,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(height: 48),
                      isTablet
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _QuickLinks(onTap: _launchUrl)),
                                Expanded(
                                  child: _ServicesLinks(onTap: _launchUrl),
                                ),
                                Expanded(
                                  child: _ConnectSection(onTap: _launchUrl),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _QuickLinks(onTap: _launchUrl),
                                const SizedBox(height: 32),
                                _ServicesLinks(onTap: _launchUrl),
                                const SizedBox(height: 32),
                                _ConnectSection(onTap: _launchUrl),
                              ],
                            ),
                    ],
                  ),

            const SizedBox(height: 48),
            const Divider(color: AppColors.borderDark),
            const SizedBox(height: 24),

            // Bottom Footer
            isDesktop
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.copyright,
                        style: AppTextStyles.small.copyWith(
                          color: AppColors.textDark,
                        ),
                      ),
                      Row(
                        children: [
                          _FooterLink(text: 'Privacy Policy', onTap: () {}),
                          const SizedBox(width: 24),
                          _FooterLink(text: 'Terms of Service', onTap: () {}),
                        ],
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        AppStrings.copyright,
                        style: AppTextStyles.small.copyWith(
                          color: AppColors.textDark,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

/// Contact form widget
class _ContactForm extends StatelessWidget {
  const _ContactForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.subjectController,
    required this.messageController,
    required this.onSubmit,
    this.isLoading = false,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController subjectController;
  final TextEditingController messageController;
  final VoidCallback onSubmit;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.getInTouch,
            style: AppTextStyles.subheading.copyWith(
              color: AppColors.surfaceLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.contactDescription,
            style: AppTextStyles.bodyText.copyWith(color: AppColors.textDark),
          ),
          const SizedBox(height: 24),
          _InputField(
            controller: nameController,
            hint: 'Your Name',
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter your name' : null,
          ),
          const SizedBox(height: 16),
          _InputField(
            controller: emailController,
            hint: 'Your Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Please enter your email';
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value!)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _InputField(
            controller: subjectController,
            hint: 'Subject',
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter a subject' : null,
          ),
          const SizedBox(height: 16),
          _InputField(
            controller: messageController,
            hint: 'Your Message',
            maxLines: 4,
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter your message' : null,
          ),
          const SizedBox(height: 24),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : PrimaryButton(
                  text: AppStrings.sendMessage,
                  onPressed: onSubmit,
                  showArrow: true,
                  isFullWidth: true,
                ),
        ],
      ),
    );
  }
}

/// Custom input field for dark background
class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: AppTextStyles.bodyText.copyWith(color: AppColors.surfaceLight),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.bodyText.copyWith(color: AppColors.textDark),
        filled: true,
        fillColor: AppColors.surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}

/// Quick links section
class _QuickLinks extends StatelessWidget {
  const _QuickLinks({required this.onTap});
  final Future<void> Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    final scrollService = ScrollService.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: AppTextStyles.workTitle.copyWith(
            color: AppColors.surfaceLight,
          ),
        ),
        const SizedBox(height: 16),
        _FooterLink(text: 'Home', onTap: scrollService.scrollToHome),
        _FooterLink(text: 'About', onTap: scrollService.scrollToAbout),
        _FooterLink(text: 'Projects', onTap: scrollService.scrollToProjects),
        _FooterLink(text: 'Skills', onTap: scrollService.scrollToSkills),
      ],
    );
  }
}

/// Services links section
class _ServicesLinks extends StatelessWidget {
  const _ServicesLinks({required this.onTap});
  final Future<void> Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Services',
          style: AppTextStyles.workTitle.copyWith(
            color: AppColors.surfaceLight,
          ),
        ),
        const SizedBox(height: 16),
        _FooterLink(text: 'Flutter App Development', onTap: () => onTap('#')),
        _FooterLink(text: 'Team Leadership', onTap: () => onTap('#')),
        _FooterLink(text: 'API Integration', onTap: () => onTap('#')),
        _FooterLink(text: 'App Store Deployment', onTap: () => onTap('#')),
      ],
    );
  }
}

/// Connect section with social links
class _ConnectSection extends StatelessWidget {
  const _ConnectSection({required this.onTap});
  final Future<void> Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect',
          style: AppTextStyles.workTitle.copyWith(
            color: AppColors.surfaceLight,
          ),
        ),
        const SizedBox(height: 16),
        _FooterLink(
          text: 'GitHub',
          onTap: () => onTap('https://github.com/MrJohir'),
        ),
        _FooterLink(
          text: 'Phone: +880 1751-228824',
          onTap: () => onTap('tel:+8801751228824'),
        ),
        _FooterLink(
          text: 'Email: mdjohiruli826@gmail.com',
          onTap: () => onTap('mailto:mdjohiruli826@gmail.com'),
        ),
      ],
    );
  }
}

/// Footer link widget
class _FooterLink extends StatefulWidget {
  const _FooterLink({required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            widget.text,
            style: AppTextStyles.bodyText.copyWith(
              color: _isHovered ? AppColors.primary : AppColors.textDark,
            ),
          ),
        ),
      ),
    );
  }
}
