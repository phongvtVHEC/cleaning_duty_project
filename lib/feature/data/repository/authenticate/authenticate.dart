import 'package:cleaning_duty_project/feature/data/entities/request/authentication/login/login_request.dart';
import 'package:cleaning_duty_project/feature/data/entities/request/authentication/register/register_request.dart';
import 'package:cleaning_duty_project/feature/data/entities/response/authentication/login/login_response.dart';
import 'package:cleaning_duty_project/feature/data/entities/response/authentication/register/register_response.dart';
import 'package:cleaning_duty_project/feature/data/remote/authenticate/authenticate_network_client.dart';

abstract class IAuthenticationRepository {
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<RegisterResponse> register(RegisterRequest registerRequest);
}

class AuthenticationRepositoryImpl extends IAuthenticationRepository {
  final AuthenticateNetworkClient authenticateNetworkClient;
  AuthenticationRepositoryImpl({
    required this.authenticateNetworkClient,
  });
  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    final response = await authenticateNetworkClient.login(
        loginRequest.username!, loginRequest.password!);
    return response;
  }

  @override
  Future<RegisterResponse> register(RegisterRequest registerRequest) async {
    final response = await authenticateNetworkClient.register(
        registerRequest.username!,
        registerRequest.email!,
        registerRequest.password!);
    return response;
  }
}
