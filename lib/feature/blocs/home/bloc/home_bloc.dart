import 'package:cleaning_duty_project/feature/widget/Calendar/calendar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>(_onHomeStarted);
    on<BottomSheetEvent>(_onBottomSheetInitial);
  }
  final GlobalKey<ScaffoldState> key = GlobalKey();
  final GlobalKey<CalendarState> calendarKey = GlobalKey();
  bool isOpened = false;
  IconData iconBottomSheet = Icons.expand_less_sharp;

  void _onHomeStarted(HomeEvent event, Emitter<HomeState> emit) {
    emit(HomeInitial());
  }

  void _onBottomSheetInitial(BottomSheetEvent event, Emitter<HomeState> emit) {
    emit(BottomSheetInitial());
    emit(event.isOpened ? BottomSheetOpened() : BottomSheetClosed());
  }

  void handleBottomSheetOpened(BuildContext context) {
    isOpened = !isOpened;
    context.read<HomeBloc>().add(BottomSheetEvent(isOpened: isOpened));
  }
}
