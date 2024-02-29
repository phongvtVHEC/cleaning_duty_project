import 'dart:convert';
import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/core/errors/exceptions.dart';
import 'package:cleaning_duty_project/core/networks/network_client.dart';
import 'package:cleaning_duty_project/feature/data/db/secure_storage.dart';
import 'package:cleaning_duty_project/feature/data/entities/request/authentication/login/login_request.dart';
import 'package:cleaning_duty_project/feature/data/entities/response/authentication/login/login_response.dart';
import 'package:dio/dio.dart';

abstract class IAuthenticationRepository {
  Future<LoginResponse> login(LoginRequest loginRequest);
}

class AuthenticationRepositoryImpl extends IAuthenticationRepository {
  final NetworkClient networkClient;
  final SecureStorage secureStorage;

  AuthenticationRepositoryImpl(
    this.secureStorage, {
    required this.networkClient,
  });

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    final response = await networkClient.invoke(
      Constants.api_login,
      RequestType.post,
      requestBody: {
        "username": loginRequest.username,
        "password": loginRequest.password
      },
    );
    if (response.statusCode == 200) {
      secureStorage.saveAccessToken(response.data['accessToken']);
      secureStorage.saveRefreshToken(response.data['refreshToken']);
      return LoginResponse.fromJson(json.decode(response.data));
    } else {
      throw ServerException.withException(
          dioError: DioException(
        response: response,
        requestOptions: response.requestOptions,
      ));
    }
  }
}
