import 'package:cleaning_duty_project/feature/data/entities/request/profile/profile_request.dart';
import 'package:cleaning_duty_project/feature/data/entities/response/profile/avatar_update_response.dart';
import 'package:cleaning_duty_project/feature/data/entities/response/profile/profile_response.dart';
import 'package:cleaning_duty_project/feature/data/entities/response/profile/profile_update_response.dart';
import 'package:cleaning_duty_project/feature/data/remote/profile/profile_network_client.dart';

abstract class IProfileRepository {
  Future<ProfileResponse> getProfile(int id);
  Future<AvatarUpdateResponse> updateAvatar(String avatarBase64);
  Future<ProfileUpdateResponse> updateProfile(ProfileRequest profileRequest);
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

  @override
  Future<AvatarUpdateResponse> updateAvatar(String avatarBase64) {
    var response = profileNetworkClient.updateAvatar(avatarBase64);
    return response;
  }

  @override
  Future<ProfileUpdateResponse> updateProfile(
      ProfileRequest profileRequest) async {
    var response = await profileNetworkClient.updateProfile(
        profileRequest.name!,
        profileRequest.email!,
        profileRequest.phoneNumber!,
        profileRequest.dateOfBirth!);
    return response;
  }
}
