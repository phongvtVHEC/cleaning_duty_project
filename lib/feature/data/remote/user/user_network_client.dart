import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/core/networks/network_client.dart';
import 'package:cleaning_duty_project/feature/data/entities/response/users/users_response.dart';

class UserNetworkClient {
  final NetworkClient networkClient;

  UserNetworkClient({required this.networkClient});

  Future<UserResponse> getUser() async {
    final response =
        await networkClient.invoke(Constants.api_get_all_user, RequestType.get);
    return UserResponse.fromJson(response.data);
  }
}
