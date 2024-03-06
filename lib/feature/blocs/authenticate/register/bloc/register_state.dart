part of 'register_bloc.dart';

sealed class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterProgress extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {}

class CleanErrorEmailSuccess extends RegisterState {}

class CleanErrorPasswordSuccess extends RegisterState {}

class CleanErrorPasswordConfirmSuccess extends RegisterState {}

class CleanErrorUsernameSuccess extends RegisterState {}
