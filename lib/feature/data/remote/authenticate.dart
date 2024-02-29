import 'dart:convert';

import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/core/errors/exceptions.dart';
import 'package:dio/dio.dart';

abstract class IAuthenticationRepository {
  Future<dynamic> login();
}

class AuthenticationRepositoryImpl extends IAuthenticationRepository {
  late final Dio dio;

  @override
  Future<dynamic> login() async {
    final response = await dio.post(
      Constants.api_login,
    );
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.toString());
      return responseBody;
    } else {
      throw ServerException();
    }
  }
}
