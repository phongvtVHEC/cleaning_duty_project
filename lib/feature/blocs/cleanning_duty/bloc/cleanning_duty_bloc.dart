import 'package:cleaning_duty_project/feature/data/repository/users/users.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cleanning_duty_event.dart';
part 'cleanning_duty_state.dart';

class CleanningDutyBloc extends Bloc<CleanningDutyEvent, CleanningDutyState> {
  CleanningDutyBloc({required this.usersRepositoryImpl})
      : super(CleanningDutyInitial()) {
    on<CleanningDutyStarted>(_onInitialCleanningDuty);
  }
  final UsersRepositoryImpl usersRepositoryImpl;
  List<Map<String, String>>? mappedList;

  Future<void> _onInitialCleanningDuty(
      CleanningDutyStarted event, Emitter<CleanningDutyState> emit) async {
    emit(CleanningDutyInitial());
    try {
      emit(CleanningDutyProgress());
      var response = await usersRepositoryImpl.getUsers();
      if (response.data?.user != null) {
        mappedList = response.data!.user!.map((user) {
          return {
            'id': user.id.toString(),
            'label': user.name ?? 'Unknown',
          };
        }).toList();
      }
      emit(CleanningDutySuccess());
    } catch (e) {
      emit(CleanningDutyFailure());
    }
  }
}
