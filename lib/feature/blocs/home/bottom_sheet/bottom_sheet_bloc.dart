import 'package:cleaning_duty_project/feature/widget/BottomSheetActionBar/package/solidController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_sheet_event.dart';
part 'bottom_sheet_state.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  BottomSheetBloc() : super(BottomSheetClosed()) {
    on<BottomSheetStarted>(_onBottomSheetOpened);
  }
  SolidController solidController = SolidController();

  void _onBottomSheetOpened(
      BottomSheetStarted event, Emitter<BottomSheetState> emit) {
    if (event.isOpened) {
      if (solidController.isOpened == true) emit(BottomSheetOpened());
    } else {
      if (solidController.isOpened == false) emit(BottomSheetClosed());
    }
  }

  void handleBottomSheetOpened(BuildContext context) {
    context.read<BottomSheetBloc>().add(BottomSheetStarted(true));
    solidController.show();
  }

  void handleBottomSheetClosed(BuildContext context) {
    context.read<BottomSheetBloc>().add(BottomSheetStarted(false));
    solidController.hide();
  }
}
