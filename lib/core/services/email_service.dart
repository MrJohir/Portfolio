/// Abstract email service interface
/// Platform-specific implementations handle the actual sending
abstract class EmailService {
  Future<EmailResult> sendEmail({
    required String fromName,
    required String fromEmail,
    required String subject,
    required String message,
  });
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
