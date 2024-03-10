import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/core/errors/exceptions.dart';
import 'package:cleaning_duty_project/core/networks/network_client.dart';
import 'package:cleaning_duty_project/feature/data/db/local_client.dart';
import 'package:cleaning_duty_project/feature/data/db/secure_storage.dart';
import 'package:cleaning_duty_project/feature/data/entities/response/authentication/login/login_response.dart';
import 'package:cleaning_duty_project/feature/data/entities/response/authentication/register/register_response.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthenticateNetworkClient {
  final NetworkClient networkClient;
  final SecureStorageImpl secureStorage;
  final LocalClientImpl localClientImpl;

  AuthenticateNetworkClient(
      {required this.localClientImpl,
      required this.secureStorage,
      required this.networkClient});

  Future<LoginResponse> login(String username, String password) async {
    final response = await networkClient.invoke(
      Constants.api_login,
      RequestType.post,
      requestBody: {"username": username, "password": password},
    );
    if (response.statusCode == 200) {
      await secureStorage.saveAccessToken(response.data['accessToken']);
      await secureStorage.saveRefreshToken(response.data['refreshToken']);
      Map<String, dynamic> currentUser =
          JwtDecoder.decode(response.data['accessToken']);
      await localClientImpl.saveData("currentUser", currentUser);
      return LoginResponse.fromJson(response.data);
    } else {
      throw ServerException.withException(
          dioError: DioException(
        response: response,
        requestOptions: response.requestOptions,
      ));
    }
  }

  Future<String?> getAccessToken() async {
    final response = await secureStorage.getAccessToken();
    return response;
  }

  Future<RegisterResponse> register(
      String username, String email, String password) async {
    final response = await networkClient.invoke(
      Constants.api_register,
      RequestType.post,
      requestBody: {"username": username, "email": email, "password": password},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterResponse.fromJson(response.data);
    } else {
      throw ServerException.withException(
          dioError: DioException(
        response: response,
        requestOptions: response.requestOptions,
      ));
    }
  }

  Future<bool> logout() async {
    await secureStorage.removeAllAsync();
    await localClientImpl.removeAll();
    return true;
  }
}
