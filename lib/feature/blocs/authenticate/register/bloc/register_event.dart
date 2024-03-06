part of 'register_bloc.dart';

class RegisterEvent {}

class RegisterStarted extends RegisterEvent {
  final RegisterRequest registerRequest;

  RegisterStarted({required this.registerRequest});
}

class CleanErrorField extends RegisterEvent {
  final String field;

  CleanErrorField({required this.field});
}
