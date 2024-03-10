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
  }

  void _onInitialProfile(ProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileInitial());
    try {
      var currentUser = localClientImpl.readData('currentUser');
      final profileResponse =
          await profileRepositoryImpl.getProfile(currentUser['id']);
      image = profileResponse.avatarUrl ?? '';
      nameController.text = profileResponse.name ?? '';
      emailController.text = profileResponse.email ?? '';
      phoneController.text = profileResponse.phoneNumber ?? '';
      dateOfBirth = profileResponse.dateOfBirth ?? '';
      emit(GetProfileSuccess(profileResponse));
    } catch (e) {
      emit(GetProfileFail(e.toString()));
    }
  }
}
