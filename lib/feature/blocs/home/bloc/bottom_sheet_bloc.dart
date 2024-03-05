import 'package:flutter_bloc/flutter_bloc.dart';
part 'bottom_sheet_event.dart';
part 'bottom_sheet_state.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  BottomSheetBloc() : super(BottomSheetInitial()) {
    on<BottomSheetStarted>(_onBottomSheetStarted);
  }
  void _onBottomSheetStarted(
      BottomSheetStarted event, Emitter<BottomSheetState> emit) {
    emit(BottomSheetInitial());
  }
}
