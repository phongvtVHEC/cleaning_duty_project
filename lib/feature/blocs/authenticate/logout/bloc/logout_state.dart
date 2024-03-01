part of 'logout_bloc.dart';

sealed class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutProgress extends LogoutState {}

class LogoutSuccess extends LogoutState {}

class LogoutFailure extends LogoutState {}
