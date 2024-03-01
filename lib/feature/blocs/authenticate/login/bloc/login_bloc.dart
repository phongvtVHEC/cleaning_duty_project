import 'package:cleaning_duty_project/core/errors/exceptions.dart';
import 'package:cleaning_duty_project/feature/data/db/secure_storage.dart';
import 'package:cleaning_duty_project/feature/data/entities/request/authentication/login/login_request.dart';
import 'package:cleaning_duty_project/feature/data/repository/authenticate/authenticate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.authenticationRepository, this.secureStorage)
      : super(LoginInitial()) {
    on<LoginStarted>(_onLoginStarted);
    on<HandleToken>(_onHandleToken);
  }

  final AuthenticationRepositoryImpl authenticationRepository;
  final SecureStorageImpl secureStorage;

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
    var result = await secureStorage.getAccessToken();
    if (result != null) {
      emit(HandleTokenSuccess(token: result));
    } else {
      emit(HandleTokenFailure());
    }
  }
}
