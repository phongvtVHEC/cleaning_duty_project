import 'dart:convert';

import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/core/errors/exceptions.dart';
import 'package:cleaning_duty_project/feature/data/entities/request/authentication/login/login_request.dart';
import 'package:cleaning_duty_project/feature/data/entities/response/authentication/login/login_response.dart';
import 'package:dio/dio.dart';

abstract class IAuthenticationRepository {
  Future<LoginResponse> login(LoginRequest loginRequest);
}

class AuthenticationRepositoryImpl extends IAuthenticationRepository {
  late final Dio dio;

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    final response = await dio.post(
      Constants.api_login,
      data: {
        "username": loginRequest.username,
        "password": loginRequest.password
      },
    );
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(response.data));
    } else {
      throw ServerException();
    }
  }
}
