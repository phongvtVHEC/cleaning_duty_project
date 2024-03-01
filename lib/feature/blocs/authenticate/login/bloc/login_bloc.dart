import 'package:cleaning_duty_project/core/errors/exceptions.dart';
import 'package:cleaning_duty_project/feature/data/entities/request/authentication/login/login_request.dart';
import 'package:cleaning_duty_project/feature/data/repository/authenticate/authenticate.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.authenticationRepository) : super(LoginInitial()) {
    on<LoginStarted>(_onLoginStarted);
    on<HandleToken>(_onHandleToken);
  }

  final AuthenticationRepositoryImpl authenticationRepository;

  void _onLoginStarted(LoginStarted event, Emitter<LoginState> emit) async {
    emit(LoginProgress());
    try {
      final response = await authenticationRepository.login(event.loginRequest);
      if (response.accessToken != null) {
        emit(LoginSuccess());
      }
    } on ServerException {
      emit(LoginFailure());
    }
  }

  void _onHandleToken(HandleToken event, Emitter<LoginState> emit) async {
    var result = await authenticationRepository.getAccessToken();
    if (result != null) {
      emit(HandleTokenSuccess(token: result));
    } else {
      emit(HandleTokenFailure());
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
}
