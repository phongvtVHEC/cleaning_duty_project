part of 'home_bloc.dart';

class HomeEvent {}

class HomeStarted extends HomeEvent {
  final bool isBottomSheetOpened;
  HomeStarted(this.isBottomSheetOpened);
}

class BottomSheet extends HomeEvent {
  final bool isBottomSheetOpened;
  BottomSheet(this.isBottomSheetOpened);
}

class HomeClose extends HomeEvent {
  final bool isBottomSheetOpened;
  HomeClose(this.isBottomSheetOpened);
}

class DateBar extends HomeEvent {}
