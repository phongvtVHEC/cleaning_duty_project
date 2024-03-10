import 'package:cleaning_duty_project/core/utils/validation_util.dart';
import 'package:cleaning_duty_project/feature/data/entities/request/authentication/register/register_request.dart';
import 'package:cleaning_duty_project/feature/data/repository/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepositoryImpl authenticationRepository;
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String errorEmail = '';
  String errorPassword = '';
  String errorPasswordConfirm = '';
  String errorUsername = '';
  bool isDisable = false;

  RegisterBloc(this.authenticationRepository) : super(RegisterInitial()) {
    on<RegisterStarted>(_onRegisterStarted);
    on<CleanErrorField>(_cleanErrorField);
  }

  void _onRegisterStarted(
      RegisterStarted event, Emitter<RegisterState> emit) async {
    emit(RegisterProgress());
    isDisable = true;
    if (!validateFields(emailController.text, usernameController.text,
        passwordController.text, confirmPasswordController.text)) {
      isDisable = false;
      emit(ValidatorDone());
      return;
    }
    try {
      var response =
          await authenticationRepository.register(event.registerRequest);
      if (response.data != null) {
        isDisable = false;
        emit(RegisterSuccess());
      } else {
        isDisable = false;
        emit(RegisterFailure());
      }
    } catch (e) {
      emit(RegisterFailure());
    }
  }

  void handleRegister(
      BuildContext context,
      TextEditingController usernameController,
      TextEditingController passwordController,
      TextEditingController emailController) {
    context.read<RegisterBloc>().add(
          RegisterStarted(
            registerRequest: RegisterRequest(
              username: usernameController.text,
              password: passwordController.text,
              email: emailController.text,
            ),
          ),
        );
  }

  bool validateFields(
    String email,
    String username,
    String password,
    String confirmPassword,
  ) {
    bool result = true;

    if (!ValidateUtil.isValidEmail(email)) {
      result = false;
      errorEmail = 'Sai mail rồi';
    }

    if (!ValidateUtil.isValidPassword(password) ||
        password.length < 8 ||
        password.length > 50) {
      result = false;
      errorPassword = 'Password phải từ 8-50 ký tự';
    }

    if (email.isEmpty) {
      result = false;
      errorEmail = 'Email không được để trống';
    }

    if (password.isEmpty) {
      result = false;
      errorPassword = 'Password không được để trống';
      errorPasswordConfirm = 'Confirm Password không được để trống';
    }

    if (username.isEmpty) {
      result = false;
      errorUsername = 'Username không được để trống';
    }

    if (password != confirmPassword) {
      result = false;
      errorPasswordConfirm = 'Confirm Password không trùng khớp với Password';
    }
    return result;
  }

  void _cleanErrorField(
      CleanErrorField event, Emitter<RegisterState> emit) async {
    switch (event.field) {
      case 'email':
        errorEmail = '';
        emit(CleanErrorEmailSuccess());
        break;
      case 'password':
        errorPassword = '';
        emit(CleanErrorPasswordSuccess());
        break;
      case 'passwordConfirm':
        errorPasswordConfirm = '';
        emit(CleanErrorPasswordConfirmSuccess());
        break;
      case 'username':
        errorUsername = '';
        emit(CleanErrorUsernameSuccess());
        break;
      default:
        // Handle unknown field name
        break;
    }
  }
}
