import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Universal URL launcher helper that works on all platforms
/// Handles https, http, tel, mailto, and other URL schemes
class UrlLauncherHelper {
  UrlLauncherHelper._();

  /// Launch any URL (https, http, tel, mailto, etc.)
  /// Works on Web, iOS, and Android
  static Future<bool> launch(String url) async {
    // Skip invalid URLs
    if (url.isEmpty || url == '#') {
      debugPrint('URL Launch: Skipping invalid URL: $url');
      return false;
    }

    try {
      final uri = Uri.parse(url);
      debugPrint('URL Launch: Attempting to launch: $url');

      // For mobile platforms, we need to use externalApplication mode
      // This ensures the URL opens in the default browser/app
      if (!kIsWeb) {
        // Try external application first (opens in browser/phone/email app)
        try {
          final result = await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );
          if (result) {
            debugPrint('URL Launch: Success with externalApplication mode');
            return true;
          }
        } catch (e) {
          debugPrint('URL Launch: externalApplication failed: $e');
        }

        // Fallback to platformDefault
        try {
          final result = await launchUrl(uri, mode: LaunchMode.platformDefault);
          if (result) {
            debugPrint('URL Launch: Success with platformDefault mode');
            return true;
          }
        } catch (e) {
          debugPrint('URL Launch: platformDefault failed: $e');
        }

        // Last resort: inAppWebView for web URLs
        if (uri.scheme == 'https' || uri.scheme == 'http') {
          try {
            final result = await launchUrl(uri, mode: LaunchMode.inAppWebView);
            debugPrint('URL Launch: inAppWebView result: $result');
            return result;
          } catch (e) {
            debugPrint('URL Launch: inAppWebView failed: $e');
          }
        }

        return false;
      } else {
        // For web, just use platformDefault
        return await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      debugPrint('URL Launch Error: $e');
      return false;
    }
  }

  /// Launch web URL (https/http)
  static Future<bool> launchWebUrl(String url) async {
    return launch(url);
  }

  /// Launch phone call
  static Future<bool> launchPhone(String phoneNumber) async {
    // Remove spaces and ensure proper format
    final cleanNumber = phoneNumber.replaceAll(' ', '').replaceAll('-', '');
    final url = cleanNumber.startsWith('tel:')
        ? cleanNumber
        : 'tel:$cleanNumber';
    debugPrint('Phone Launch: $url');
    return launch(url);
  }

  /// Launch email
  static Future<bool> launchEmail(
    String email, {
    String? subject,
    String? body,
  }) async {
    String url;
    if (email.startsWith('mailto:')) {
      url = email;
    } else {
      final params = <String>[];
      if (subject != null)
        params.add('subject=${Uri.encodeComponent(subject)}');
      if (body != null) params.add('body=${Uri.encodeComponent(body)}');
      url = 'mailto:$email${params.isNotEmpty ? '?${params.join('&')}' : ''}';
    }
    debugPrint('Email Launch: $url');
    return launch(url);
  }

  /// Launch GitHub profile - uses full URL to avoid any truncation
  static Future<bool> launchGitHub(String username) async {
    final url = 'https://github.com/$username';
    debugPrint('GitHub Launch: $url');
    return launch(url);
  }
}
