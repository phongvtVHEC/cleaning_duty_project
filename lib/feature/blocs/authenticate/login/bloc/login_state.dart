// ignore_for_file: public_member_api_docs, sort_constructors_first


part of 'login_bloc.dart';


sealed class LoginState {}


class LoginInitial extends LoginState {}


class LoginProgress extends LoginState {}


class LoginSuccess extends LoginState {}


class LoginFailure extends LoginState {}

