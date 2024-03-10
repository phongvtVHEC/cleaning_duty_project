import 'package:cleaning_duty_project/core/utils/image_to_base64_util.dart';
import 'package:cleaning_duty_project/feature/data/db/local_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleaning_duty_project/feature/data/entities/response/profile/profile_response.dart';
import 'package:cleaning_duty_project/feature/data/repository/profile/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepositoryImpl profileRepositoryImpl;
  final LocalClientImpl localClientImpl;
  String tempImage = "";
  String image = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String dateOfBirth = "";

  ProfileBloc(
    this.profileRepositoryImpl,
    this.localClientImpl,
  ) : super(ProfileInitial()) {
    on<ProfileEvent>(_onInitialProfile);
    on<AvatarChanged>(_onChangeAvatar);
  }

  void _onInitialProfile(ProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileInitial());
    try {
      var currentUser = localClientImpl.readData('currentUser');
      final profileResponse =
          await profileRepositoryImpl.getProfile(currentUser['id']);
      image = profileResponse.avatarUrl ?? '';
      tempImage = profileResponse.avatarUrl ?? '';
      nameController.text = profileResponse.name ?? '';
      emailController.text = profileResponse.email ?? '';
      phoneController.text = profileResponse.phoneNumber ?? '';
      dateOfBirth = profileResponse.dateOfBirth ?? '';
      emit(GetProfileSuccess(profileResponse));
    } catch (e) {
      emit(GetProfileFail(e.toString()));
    }
  }

  void _onChangeAvatar(AvatarChanged event, Emitter<ProfileState> emit) async {
    emit(UpdateAvatarProgress());
    image = await ImageToBase64Util.imageFileToBase64(image);
    var response = await profileRepositoryImpl.updateAvatar(image);
    if (response.data != null) {
      image = response.data?.avatarUrl ?? '';
      emit(UpdateAvatarSuccess());
    } else {
      emit(UpdateAvatarFail());
    }
  }
}
