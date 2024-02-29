// ignore_for_file: constant_identifier_names

class Constants {
  // App Fonts
  static const String app_font_DM_Sans = 'DM Sans';

  // App API Endpoints
  static const String api_base_url = 'http://localhost:3111';
  // Authentication API
  static const String api_login = '$api_base_url/api/auth/login';
  static const String api_register = '$api_base_url/api/auth/register';
  static const String api_refresh_token =
      '$api_base_url/api/auth/refresh-token';

  // Constant String
  static const String access_token = 'access_token';
  static const String refresh_token = 'refresh_token';
  static const String id = 'id';
}
