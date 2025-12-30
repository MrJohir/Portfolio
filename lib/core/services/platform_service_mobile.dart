import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/core/services/email_service.dart';

/// Mobile implementation of email service
/// Uses mailto: link since EmailJS doesn't support mobile apps
class EmailServiceImpl implements EmailService {
  @override
  Future<EmailResult> sendEmail({
    required String fromName,
    required String fromEmail,
    required String subject,
    required String message,
  }) async {
    try {
      final emailBody =
          '''
Name: $fromName
Email: $fromEmail

Message:
$message
''';

      final mailtoUrl = Uri(
        scheme: 'mailto',
        path: 'mdjohiruli826@gmail.com',
        query: _encodeQueryParameters({'subject': subject, 'body': emailBody}),
      );

      debugPrint('Email Service: Opening mailto: $mailtoUrl');

      final launched = await launchUrl(
        mailtoUrl,
        mode: LaunchMode.externalApplication,
      );

      if (launched) {
        return EmailResult.success(
          'Email app opened! Please send the email from your email app.',
        );
      } else {
        final fallbackLaunched = await launchUrl(
          mailtoUrl,
          mode: LaunchMode.platformDefault,
        );

        if (fallbackLaunched) {
          return EmailResult.success(
            'Email app opened! Please send the email from your email app.',
          );
        }
        return EmailResult.failure(
          'Could not open email app. Please email directly to: mdjohiruli826@gmail.com',
        );
      }
    } catch (e) {
      debugPrint('Email Service Error: $e');
      return EmailResult.failure('Error: $e');
    }
  }

  String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }
}

/// Downloads CV on mobile platform using Google Drive hosted URL
void downloadCV() async {
  // Google Drive direct download link
  // Original: https://drive.google.com/file/d/1ubP_znSFAGpbhAmTR8v477EPhCX1W69f/view?usp=sharing
  const cvUrl =
      'https://drive.google.com/uc?export=download&id=1ubP_znSFAGpbhAmTR8v477EPhCX1W69f';

  debugPrint('CV Download: Opening $cvUrl');

  try {
    final uri = Uri.parse(cvUrl);

    bool launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!launched) {
      launched = await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    }

    if (!launched) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }

    debugPrint('CV Download: Launch success = $launched');
  } catch (e) {
    debugPrint('CV Download Error: $e');
  }
}
