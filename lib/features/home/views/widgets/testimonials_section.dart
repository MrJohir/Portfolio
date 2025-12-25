// import 'package:flutter/material.dart';

// import 'package:portfolio/core/utils/constants/app_colors.dart';
// import 'package:portfolio/core/utils/constants/app_strings.dart';
// import 'package:portfolio/core/utils/responsive/responsive.dart';
// import 'package:portfolio/core/utils/theme/app_text_styles.dart';

// /// Testimonials section with client reviews
// class TestimonialsSection extends StatelessWidget {
//   const TestimonialsSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDesktop = Responsive.isDesktop(context);
//     final isTablet = Responsive.isTablet(context);

//     final testimonials = [
//       _TestimonialData(
//         quote:
//             '"Johir is an exceptional Flutter developer with strong technical skills and excellent leadership abilities. His dedication to clean code and best practices makes him a valuable team member."',
//         name: 'Bipul Sarkar',
//         role: 'Senior Mobile App Developer – Onoda Inc.',
//         avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
//         isReference: true,
//       ),
//       _TestimonialData(
//         quote:
//             '"Working with Johir on the Deep Quran app was a great experience. He delivered a production-ready application with complex features like gamification, subscription payments, and real-time audio recitation."',
//         name: 'Project Manager',
//         role: 'Softvency IT Limited',
//         avatarUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
//       ),
//       _TestimonialData(
//         quote:
//             '"Johir\'s expertise in Flutter architecture, state management, and API integration helped us deliver ServiGo on time. His attention to detail and commitment to quality are outstanding."',
//         name: 'Team Lead',
//         role: 'Softvency IT Limited',
//         avatarUrl: 'https://randomuser.me/api/portraits/women/28.jpg',
//       ),
//     ];

//     return Container(
//       color: AppColors.surfaceLight,
//       child: ResponsiveContainer(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
//         child: Column(
//           children: [
//             // Section Header
//             Text(
//               AppStrings.testimonialsSectionTitle,
//               style: AppTextStyles.sectionTitle,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               AppStrings.testimonialsSectionSubtitle,
//               style: AppTextStyles.bodyText,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 48),

//             // Testimonial Cards
//             isDesktop
//                 ? Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: testimonials
//                         .map(
//                           (t) => Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                               ),
//                               child: _TestimonialCard(data: t),
//                             ),
//                           ),
//                         )
//                         .toList(),
//                   )
//                 : Column(
//                     children: testimonials
//                         .map(
//                           (t) => Padding(
//                             padding: const EdgeInsets.only(bottom: 24),
//                             child: _TestimonialCard(data: t),
//                           ),
//                         )
//                         .toList(),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _TestimonialData {
//   const _TestimonialData({
//     required this.quote,
//     required this.name,
//     required this.role,
//     required this.avatarUrl,
//     this.isReference = false,
//   });

//   final String quote;
//   final String name;
//   final String role;
//   final String avatarUrl;
//   final bool isReference;
// }

// /// Single testimonial card
// class _TestimonialCard extends StatelessWidget {
//   const _TestimonialCard({required this.data});
//   final _TestimonialData data;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: AppColors.backgroundLight,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: data.isReference
//               ? AppColors.primary.withValues(alpha: 0.3)
//               : AppColors.borderLight,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Reference Badge
//           if (data.isReference)
//             Container(
//               margin: const EdgeInsets.only(bottom: 12),
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: AppColors.primary.withValues(alpha: 0.1),
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               child: Text(
//                 '⭐ Professional Reference',
//                 style: AppTextStyles.small.copyWith(
//                   color: AppColors.primary,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 10,
//                 ),
//               ),
//             ),
//           // Quote Icon
//           Icon(
//             Icons.format_quote,
//             color: AppColors.primary.withValues(alpha: 0.2),
//             size: 40,
//           ),
//           const SizedBox(height: 16),

//           // Quote Text
//           Text(
//             data.quote,
//             style: AppTextStyles.bodyText.copyWith(fontStyle: FontStyle.italic),
//           ),
//           const SizedBox(height: 24),

//           // Author Info
//           Row(
//             children: [
//               // Avatar
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(24),
//                 child: Image.network(
//                   data.avatarUrl,
//                   width: 48,
//                   height: 48,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => Container(
//                     width: 48,
//                     height: 48,
//                     decoration: BoxDecoration(
//                       color: AppColors.primary.withValues(alpha: 0.1),
//                       borderRadius: BorderRadius.circular(24),
//                     ),
//                     child: const Icon(Icons.person, color: AppColors.primary),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),

//               // Name and Role
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(data.name, style: AppTextStyles.workTitle),
//                   Text(data.role, style: AppTextStyles.small),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
