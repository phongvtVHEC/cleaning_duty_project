part of 'register_bloc.dart';

class RegisterEvent {}

class RegisterStarted extends RegisterEvent {
  final RegisterRequest registerRequest;

  RegisterStarted(this.registerRequest);
}
