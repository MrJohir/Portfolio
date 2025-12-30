// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;
import 'package:portfolio/core/services/email_service.dart';

/// Web implementation of email service using EmailJS
class EmailServiceImpl implements EmailService {
  // EmailJS credentials
  static const String _serviceId = 'service_7vvfp7p';
  static const String _templateId = 'template_xp80tof';
  static const String _publicKey = 'N_qzECoSIm6Bre-Z5';

  @override
  Future<EmailResult> sendEmail({
    required String fromName,
    required String fromEmail,
    required String subject,
    required String message,
  }) async {
    try {
      // Use EmailJS JavaScript SDK directly for web
      final response = await _sendViaEmailJS(
        fromName: fromName,
        fromEmail: fromEmail,
        subject: subject,
        message: message,
      );
      return response;
    } catch (e) {
      return EmailResult.failure('Failed to send email: $e');
    }
  }

  Future<EmailResult> _sendViaEmailJS({
    required String fromName,
    required String fromEmail,
    required String subject,
    required String message,
  }) async {
    try {
      // Create XMLHttpRequest for EmailJS API
      final xhr = html.HttpRequest();
      xhr.open('POST', 'https://api.emailjs.com/api/v1.0/email/send');
      xhr.setRequestHeader('Content-Type', 'application/json');

      final body =
          '''
{
  "service_id": "$_serviceId",
  "template_id": "$_templateId",
  "user_id": "$_publicKey",
  "template_params": {
    "from_name": "$fromName",
    "from_email": "$fromEmail",
    "subject": "$subject",
    "message": "$message",
    "to_email": "mdjohiruli826@gmail.com"
  }
}
''';

      // Send request
      xhr.send(body);

      // Wait for response
      await xhr.onLoadEnd.first;

      if (xhr.status == 200) {
        return EmailResult.success('Message sent successfully!');
      } else {
        return EmailResult.failure('Failed to send: ${xhr.responseText}');
      }
    } catch (e) {
      return EmailResult.failure('Network error: $e');
    }
  }
}

/// Downloads CV on web platform
void downloadCV() {
  html.AnchorElement(href: 'Johirul.pdf')
    ..setAttribute('download', 'Johirul_CV.pdf')
    ..click();
}
