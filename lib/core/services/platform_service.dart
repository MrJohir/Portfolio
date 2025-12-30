// Platform-agnostic service exports
// Automatically uses correct implementation based on platform
export 'platform_service_mobile.dart'
    if (dart.library.html) 'platform_service_web.dart';
