import 'package:cleaning_duty_project/feature/data/entities/request/authentication/register/register_request.dart';
import 'package:cleaning_duty_project/feature/data/repository/authenticate/authenticate.dart';
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
}
