import 'package:cleaning_duty_project/feature/widget/BottomSheetActionBar/package/solidController.dart';
import 'package:cleaning_duty_project/feature/widget/Calendar/package/calendar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  String? currentMonth;
  String? currentYear;

  HomeBloc() : super(HomeInitial()) {
    on<HomeStarted>(_onHomeStarted);
    on<BottomSheet>(_onBottomSheetState);
    on<HomeClose>(_onResetState);
    on<DateBar>(_onDateBarChanged);
  }

  SolidController solidController = SolidController();
  final GlobalKey<ScaffoldState> key = GlobalKey();
  final GlobalKey<CalendarState> calendarKey = GlobalKey();

  void _onHomeStarted(HomeStarted event, Emitter<HomeState> emit) {
    currentMonth = calendarKey.currentState?.getCurrentMonthString() ?? '';
    currentYear = calendarKey.currentState?.getCurrentYearString() ?? '';

    emit(HomeInitial());
    emit(DateBarUpdated(
      currentMonth ?? '',
      currentYear ?? '',
    ));
  }

  void _onBottomSheetState(BottomSheet event, Emitter<HomeState> emit) {
    if (event.isBottomSheetOpened) {
      emit(BottomSheetOpened());
    } else {
      emit(BottomSheetClosed());
    }
  }

  void handleBottomSheetOpened(BuildContext context) {
    context.read<HomeBloc>().add(BottomSheet(true));
    solidController.show();
  }

  void handleBottomSheetClosed(BuildContext context) {
    context.read<HomeBloc>().add(BottomSheet(false));
    solidController.hide();
  }

  void resetState(BuildContext context) {
    context.read<HomeBloc>().add(HomeClose(false));
    solidController.hide();
    handleBottomSheetClosed(context);
  }

  void _onResetState(HomeClose event, Emitter<HomeState> emit) {
    emit(HomeReset());
  }

  void _onDateBarChanged(DateBar event, Emitter<HomeState> emit) {
    currentMonth = calendarKey.currentState?.getCurrentMonthString();
    currentYear = calendarKey.currentState?.getCurrentYearString();
    emit(DateBarUpdated(
      currentMonth ?? '',
      currentYear ?? '',
    ));
  }
}
