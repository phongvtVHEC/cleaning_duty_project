part of 'login_bloc.dart';

sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginProgress extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {}

class ValidatorDone extends LoginState {}

class CleanErrorPasswordSuccess extends LoginState {}

class CleanErrorUsernameSuccess extends LoginState {}
