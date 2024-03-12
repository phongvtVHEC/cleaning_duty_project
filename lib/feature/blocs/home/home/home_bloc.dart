import 'package:cleaning_duty_project/feature/widget/BottomSheetActionBar/package/solidController.dart';
import 'package:cleaning_duty_project/feature/widget/Calendar/package/calendar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>(_onHomeStarted);
    on<HomeClose>(_onResetState);
  }
  SolidController solidController = SolidController();
  final GlobalKey<ScaffoldState> key = GlobalKey();
  final GlobalKey<CalendarState> calendarKey = GlobalKey();
  String? currentMonth = '';

  void _onHomeStarted(HomeEvent event, Emitter<HomeState> emit) {
    emit(HomeInitial());
    _onBottomSheetStarted(event, emit);
  }

  void _onBottomSheetStarted(HomeEvent event, Emitter<HomeState> emit) {
    if (event is BottomSheetStarted) {
      if (event.isBottomSheetOpened) {
        emit(BottomSheetOpened());
      } else {
        emit(BottomSheetClosed());
      }
    }
  }

  void handleBottomSheetOpened(BuildContext context) {
    context.read<HomeBloc>().add(BottomSheetStarted(true));
    solidController.show();
  }

  void handleBottomSheetClosed(BuildContext context) {
    context.read<HomeBloc>().add(BottomSheetStarted(false));
    solidController.hide();
  }

  void resetState(BuildContext context) {
    context.read<HomeBloc>().add(HomeClose());
    solidController.hide();
    handleBottomSheetClosed(context);
  }

  void _onResetState(HomeClose event, Emitter<HomeState> emit) {
    emit(HomeReset());
  }

  String getMonthString(String dateString) {
    List<String> parts = dateString.split(' ');

    // Check if the parts array has at least 3 elements
    if (parts.length < 3) return 'Invalid format';

    // Get the month string, which is the second element after 'de'
    String monthString = parts[2].toUpperCase();

    // Remove the comma if present
    monthString = monthString.replaceAll(',', '');

    return monthString;
  }

  String getYearString(String dateString) {
    List<String> parts = dateString.split(' ');

    // Check if the parts array has at least 3 elements
    if (parts.length < 3) return 'Invalid format';

    // Get the year string, which is the third element
    String yearString = parts[3];

    return yearString;
  }
}
