import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// EmailJS service for sending contact form emails without backend
/// 
/// Setup Instructions:
/// 1. Go to https://www.emailjs.com/ and create a free account
/// 2. Add an email service (Gmail, Outlook, etc.) in "Email Services"
/// 3. Create an email template in "Email Templates" with these variables:
///    - {{from_name}} - Sender's name
///    - {{from_email}} - Sender's email
///    - {{subject}} - Email subject
///    - {{message}} - Email message
/// 4. Copy your Service ID, Template ID, and Public Key
/// 5. Update the constants below with your credentials
class EmailJSService {
  EmailJSService._();
  static final EmailJSService instance = EmailJSService._();

  // ⚠️ IMPORTANT: Replace these with your EmailJS credentials
  // Get these from your EmailJS dashboard: https://dashboard.emailjs.com/
  static const String _serviceId = 'YOUR_SERVICE_ID';      // e.g., 'service_xxxxxxx'
  static const String _templateId = 'YOUR_TEMPLATE_ID';    // e.g., 'template_xxxxxxx'
  static const String _publicKey = 'YOUR_PUBLIC_KEY';      // e.g., 'xxxxxxxxxxx'

  static const String _emailJSUrl = 'https://api.emailjs.com/api/v1.0/email/send';

  /// Send email using EmailJS API
  /// Returns true if email sent successfully, false otherwise
  Future<EmailResult> sendEmail({
    required String fromName,
    required String fromEmail,
    required String subject,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_emailJSUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': _serviceId,
          'template_id': _templateId,
          'user_id': _publicKey,
          'template_params': {
            'from_name': fromName,
            'from_email': fromEmail,
            'subject': subject,
            'message': message,
            'to_email': 'mdjohiruli826@gmail.com',
          },
        }),
      );

      // Debug: Print response for troubleshooting
      debugPrint('EmailJS Response Status: ${response.statusCode}');
      debugPrint('EmailJS Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return EmailResult.success('Message sent successfully!');
      } else {
        // Show actual error from EmailJS
        return EmailResult.failure('Error: ${response.body}');
      }
    } catch (e) {
      debugPrint('EmailJS Error: $e');
      return EmailResult.failure('Network error: $e');
    }
  }
}

/// Result class for email sending operation
class EmailResult {
  final bool isSuccess;
  final String message;

  EmailResult._({required this.isSuccess, required this.message});

  factory EmailResult.success(String message) => 
      EmailResult._(isSuccess: true, message: message);
  
  factory EmailResult.failure(String message) => 
      EmailResult._(isSuccess: false, message: message);
}
