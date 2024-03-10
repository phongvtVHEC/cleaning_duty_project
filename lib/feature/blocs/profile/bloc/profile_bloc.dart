import 'package:cleaning_duty_project/core/utils/image_to_base64_util.dart';
import 'package:cleaning_duty_project/feature/data/entities/request/profile/profile_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleaning_duty_project/feature/data/repository/profile/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  String tempImage = "";
  String image = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String dateOfBirth = "";
  bool isDisable = false;

  ProfileBloc(
    this.profileRepositoryImpl,
  ) : super(ProfileInitial()) {
    on<ProfileStarted>(_onInitialProfile);
    on<AvatarChanged>(_onChangeAvatar);
    on<ProfileChanged>(_onChangeProfile);
  }
  final ProfileRepositoryImpl profileRepositoryImpl;

  void _onInitialProfile(ProfileEvent event, Emitter<ProfileState> emit) async {
    emit(GetProfileProgress());
    try {
      final profileResponse = await profileRepositoryImpl.getProfile();
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
    try {
      var response = await profileRepositoryImpl.updateAvatar(image);
      if (response.data != null) {
        image = response.data?.avatarUrl ?? '';
        emit(UpdateAvatarSuccess());
      } else {
        emit(UpdateAvatarFail());
      }
    } catch (e) {
      emit(UpdateAvatarFail());
    }
  }

  void updateAvatar(String newImage) async {
    image = await ImageToBase64Util.imageFileToBase64(newImage);
    add(AvatarChanged(image: image));
  }

  void _onChangeProfile(
      ProfileChanged event, Emitter<ProfileState> emit) async {
    emit(UpdateProfileProgress());

    isDisable = true;
    try {
      var response =
          await profileRepositoryImpl.updateProfile(event.profileRequest);
      if (response.data != null) {
        isDisable = false;
        nameController.text = event.profileRequest.name ?? '';
        emailController.text = event.profileRequest.email ?? '';
        phoneController.text = event.profileRequest.phoneNumber ?? '';
        dateOfBirth = event.profileRequest.dateOfBirth ?? '';
        emit(UpdateProfileSuccess());
      } else {
        isDisable = false;
        emit(UpdateProfileFail());
      }
    } catch (e) {
      isDisable = false;
      emit(UpdateProfileFail());
    }
  }

  void updateProfile() {
    add(
      ProfileChanged(
        profileRequest: ProfileRequest(
          name: nameController.text,
          email: emailController.text,
          phoneNumber: phoneController.text,
          dateOfBirth: dateOfBirth,
        ),
      ),
    );
  }
}
