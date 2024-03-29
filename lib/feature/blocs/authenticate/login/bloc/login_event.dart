part of 'login_bloc.dart';

class LoginEvent {}

class LoginStarted extends LoginEvent {
  final LoginRequest loginRequest;

  LoginStarted({required this.loginRequest});
}

class CleanErrorFields extends LoginEvent {
  final String field;

  CleanErrorFields({required this.field});
}
