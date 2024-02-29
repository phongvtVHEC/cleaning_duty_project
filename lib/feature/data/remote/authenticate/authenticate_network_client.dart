import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/core/errors/exceptions.dart';
import 'package:cleaning_duty_project/core/networks/network_client.dart';
import 'package:cleaning_duty_project/feature/data/db/secure_storage.dart';
import 'package:cleaning_duty_project/feature/data/entities/response/authentication/login/login_response.dart';
import 'package:dio/dio.dart';

class AuthenticateNetworkClient {
  final NetworkClient networkClient;
  final SecureStorage secureStorage;

  AuthenticateNetworkClient(
      {required this.secureStorage, required this.networkClient});

  Future<LoginResponse> login(String username, String password) async {
    final response = await networkClient.invoke(
      Constants.api_login,
      RequestType.post,
      requestBody: {"username": username, "password": password},
    );
    if (response.statusCode == 200) {
      secureStorage.saveAccessToken(response.data['accessToken']);
      secureStorage.saveRefreshToken(response.data['refreshToken']);
      return LoginResponse.fromJson(response.data);
    } else {
      throw ServerException.withException(
          dioError: DioException(
        response: response,
        requestOptions: response.requestOptions,
      ));
    }
  }
}
