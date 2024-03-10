part of 'profile_bloc.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetProfileProgress extends ProfileState {}

final class GetProfileSuccess extends ProfileState {}

final class GetProfileFail extends ProfileState {}

final class UpdateAvatarProgress extends ProfileState {}

final class UpdateAvatarSuccess extends ProfileState {}

final class UpdateAvatarFail extends ProfileState {}

final class UpdateProfileProgress extends ProfileState {}

final class UpdateProfileSuccess extends ProfileState {}

final class UpdateProfileFail extends ProfileState {}
