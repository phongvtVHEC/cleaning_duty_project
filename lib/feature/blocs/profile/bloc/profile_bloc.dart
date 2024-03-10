import 'package:cleaning_duty_project/core/utils/image_to_base64_util.dart';
import 'package:cleaning_duty_project/feature/data/db/local_client.dart';
import 'package:cleaning_duty_project/feature/data/entities/request/profile/profile_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<ProfileChanged>(_onChangeProfile);
  }

  void _onInitialProfile(ProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileInitial());
    try {
      var currentUser = localClientImpl.readData('currentUser');
      final profileResponse =
          await profileRepositoryImpl.getProfile(currentUser['id']);
      image = profileResponse.data?.avatarUrl ?? '';
      tempImage = profileResponse.data?.avatarUrl ?? '';
      nameController.text = profileResponse.data?.name ?? '';
      emailController.text = profileResponse.data?.email ?? '';
      phoneController.text = profileResponse.data?.phoneNumber ?? '';
      dateOfBirth = profileResponse.data?.dateOfBirth ?? '';
      emit(GetProfileSuccess());
    } catch (e) {
      emit(GetProfileFail());
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

  void _onChangeProfile(
      ProfileChanged event, Emitter<ProfileState> emit) async {
    emit(UpdateProfileProgress());
    var profileRequest = ProfileRequest(
      name: nameController.text,
      email: emailController.text,
      phoneNumber: phoneController.text,
      dateOfBirth: dateOfBirth,
    );
    var response = await profileRepositoryImpl.updateProfile(profileRequest);
    if (response.data != null) {
      emit(UpdateProfileSuccess());
    } else {
      emit(UpdateProfileFail());
    }
  }
}
