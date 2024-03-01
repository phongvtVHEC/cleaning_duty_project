import 'package:cleaning_duty_project/feature/data/repository/authenticate/authenticate.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc(this.authenticationRepository) : super(LogoutInitial()) {
    on<LogoutStarted>(_onLogoutStarted);
  }
  final AuthenticationRepositoryImpl authenticationRepository;

  void _onLogoutStarted(LogoutStarted event, Emitter<LogoutState> emit) async {
    final response = await authenticationRepository.logout();

    if (response) {
      emit(LogoutSuccess());
    } else {
      emit(LogoutFailure());
    }
  }

  void handleLogout(BuildContext context) {
    context.read<LogoutBloc>().add(LogoutStarted());
  }
}
