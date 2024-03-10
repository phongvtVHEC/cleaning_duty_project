part of 'profile_bloc.dart';

class ProfileEvent {}

class ProfileStarted extends ProfileEvent {}

class AvatarChanged extends ProfileEvent {
  final String image;
  AvatarChanged({
    required this.image,
  });
}

class ProfileChanged extends ProfileEvent {
  final ProfileRequest profileRequest;
  ProfileChanged({
    required this.profileRequest,
  });
}
