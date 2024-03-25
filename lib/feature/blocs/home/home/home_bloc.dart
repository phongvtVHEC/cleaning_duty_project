// ignore_for_file: use_build_context_synchronously

import 'package:cleaning_duty_project/feature/data/entities/response/cleanning_duty/cleanning_duties_response.dart';
import 'package:cleaning_duty_project/feature/data/repository/cleanning_duty/cleanning_duty.dart';
import 'package:cleaning_duty_project/feature/widget/BottomSheetActionBar/package/solidController.dart';
import 'package:cleaning_duty_project/feature/widget/Calendar/package/calendar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  String? currentMonth;
  String? currentYear;
  List<CleaningDutiesResponse>? cleaningDutyList = [];

  HomeBloc(this.cleanningDutyRepositoryImpl) : super(HomeInitial()) {
    on<HomeStarted>(_onHomeStarted);
    on<BottomSheet>(_onBottomSheetState);
    on<HomeClose>(_onResetState);
    on<DateBar>(_onDateBarChanged);
  }

  SolidController solidController = SolidController();
  final GlobalKey<ScaffoldState> key = GlobalKey();
  final GlobalKey<CalendarState> calendarKey = GlobalKey();
  final CleanningDutyRepositoryImpl cleanningDutyRepositoryImpl;

  void _onHomeStarted(HomeStarted event, Emitter<HomeState> emit) async {
    currentMonth =
        await calendarKey.currentState?.getCurrentMonthString() ?? '';
    currentYear = await calendarKey.currentState?.getCurrentYearString() ?? '';
    await handleGetCleaningDuty(currentYear, currentMonth);
    emit(HomeInitial());
    emit(DateBarUpdated());
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

  void _onDateBarChanged(DateBar event, Emitter<HomeState> emit) async {
    emit(DateBarUpdated());
  }

  Future<void> handleDateBarForwardUpdated(BuildContext context) async {
    int month = int.parse(currentMonth ?? '');
    int year = int.parse(currentYear ?? '');

    if (month == 12) {
      month = 1;
      year++;
    } else {
      month++;
    }

    currentMonth = month.toString();
    currentYear = year.toString();
    await handleGetCleaningDuty(currentYear, currentMonth);
    context
        .read<HomeBloc>()
        .add(DateBar(currentMonth ?? '', currentYear ?? ''));
  }

  Future<void> handleDateBarPreviousUpdated(BuildContext context) async {
    int month = int.parse(currentMonth ?? '');
    int year = int.parse(currentYear ?? '');

    if (month == 1) {
      month = 12;
      year--;
    } else {
      month--;
    }

    currentMonth = month.toString();
    currentYear = year.toString();
    await handleGetCleaningDuty(currentYear, currentMonth);
    context
        .read<HomeBloc>()
        .add(DateBar(currentMonth ?? '', currentYear ?? ''));
  }

  String convertMonthFromNumberToString(String month) {
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    int index = int.tryParse(month) ?? 1;
    if (index >= 1 && index <= 12) {
      return months[index - 1];
    } else {
      return 'January';
    }
  }

  Future<void> handleGetCleaningDuty(String? year, String? month) async {
    var response = await cleanningDutyRepositoryImpl.getCleanningDuty(
        year ?? '', month ?? '');
    cleaningDutyList = response.cleaningDutiesResponse;
    calendarKey.currentState?.updateCleanDutyList(cleaningDutyList ?? []);
  }

  Future<int> handleQuickAssignDuties() async {
    var response = await cleanningDutyRepositoryImpl.quickAssignDuties();
    return response;
  }
}
