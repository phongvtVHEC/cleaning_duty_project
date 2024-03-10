import 'package:cleaning_duty_project/feature/data/entities/response/profile/profile_response.dart';
import 'package:cleaning_duty_project/feature/data/remote/profile/profile_network_client.dart';

abstract class IProfileRepository {
  Future<ProfileResponse> getProfile(int id);
}

class ProfileRepositoryImpl extends IProfileRepository {
  final ProfileNetworkClient profileNetworkClient;
  ProfileRepositoryImpl({
    required this.profileNetworkClient,
  });
  @override
  Future<ProfileResponse> getProfile(int id) async {
    var response = profileNetworkClient.getProfile(id);
    return response;
  }
}
