// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  // App Fonts
  static const String app_font_DM_Sans = 'DM Sans';

  // App API Endpoints
  static String api_base_url = '${dotenv.env['API_BASE_URL']}';
  // Authentication API
  static final String api_login = '$api_base_url/api/auth/login';
  static final String api_register = '$api_base_url/api/auth/register';
  static final String api_refresh_token =
      '$api_base_url/api/auth/refresh-token';

  // Constant String
  static const String access_token = 'access_token';
  static const String refresh_token = 'refresh_token';
  static const String id = 'id';
}
