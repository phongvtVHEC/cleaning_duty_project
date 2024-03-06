import 'package:cleaning_duty_project/feature/data/entities/request/authentication/register/register_request.dart';
import 'package:cleaning_duty_project/feature/data/repository/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepositoryImpl authenticationRepository;

  RegisterBloc(this.authenticationRepository) : super(RegisterInitial()) {
    on<RegisterStarted>(_onRegisterStarted);
  }

  void _onRegisterStarted(RegisterStarted event, Emitter<RegisterState> emit) {
    emit(RegisterProgress());
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
}
