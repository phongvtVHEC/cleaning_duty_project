import 'package:cleaning_duty_project/feature/data/entities/response/users/users_response.dart';
import 'package:cleaning_duty_project/feature/data/remote/user/user_network_client.dart';

abstract class IUsersRepository {
  Future<UserResponse> getUsers();
}

class UsersRepositoryImpl implements IUsersRepository {
  final UserNetworkClient userNetworkClient;

  UsersRepositoryImpl({required this.userNetworkClient});

  @override
  Future<UserResponse> getUsers() async {
    var response = await userNetworkClient.getUser();
    return response;
  }
}
