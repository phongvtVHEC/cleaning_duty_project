import 'package:cleaning_duty_project/core/errors/exceptions.dart';
import 'package:cleaning_duty_project/core/utils/validation_ulti.dart';
import 'package:cleaning_duty_project/feature/data/entities/request/authentication/login/login_request.dart';
import 'package:cleaning_duty_project/feature/data/repository/authenticate/authenticate.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.authenticationRepository) : super(LoginInitial()) {
    on<LoginStarted>(_onLoginStarted);
    on<CleanErrorFields>(_cleanErrorField);
  }

  final AuthenticationRepositoryImpl authenticationRepository;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isDisable = false;
  String errorPassword = '';
  String errorUsername = '';

  void _onLoginStarted(LoginStarted event, Emitter<LoginState> emit) async {
    isDisable = true;
    emit(LoginProgress());
    if (!validateFields(usernameController.text, passwordController.text)) {
      isDisable = false;
      emit(ValidatorDone());
      return;
    }
    try {
      final response = await authenticationRepository.login(event.loginRequest);
      if (response.accessToken != null) {
        isDisable = false;
        emit(LoginSuccess());
      }
    } on ServerException {
      isDisable = false;
      emit(LoginFailure());
    }
  }

  void handleLogin(
      BuildContext context,
      TextEditingController usernameController,
      TextEditingController passwordController) {
    context.read<LoginBloc>().add(
          LoginStarted(
            loginRequest: LoginRequest(
              username: usernameController.text,
              password: passwordController.text,
            ),
          ),
        );
  }

  bool validateFields(
    String username,
    String password,
  ) {
    bool result = true;

    if (!ValidateUtil.isValidPassword(password) ||
        password.length < 8 ||
        password.length > 50) {
      result = false;
      errorPassword = 'Password phải từ 8-50 ký tự';
    }

    if (username.isEmpty) {
      result = false;
      errorUsername = 'Username không được để trống';
    }
    return result;
  }

  void _cleanErrorField(
      CleanErrorFields event, Emitter<LoginState> emit) async {
    switch (event.field) {
      case 'password':
        errorPassword = '';
        emit(CleanErrorPasswordSuccess());
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
