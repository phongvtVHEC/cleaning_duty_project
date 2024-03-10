part of 'profile_bloc.dart';

class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetProfileSuccess extends ProfileState {
  final ProfileResponse profileResponse;
  GetProfileSuccess(this.profileResponse);
}

final class GetProfileFail extends ProfileState {
  final String message;
  GetProfileFail(this.message);
}

final class UpdateAvatarProgress extends ProfileState {}

final class UpdateAvatarSuccess extends ProfileState {}

final class UpdateAvatarFail extends ProfileState {}
