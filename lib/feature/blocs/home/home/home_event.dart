part of 'home_bloc.dart';

class HomeEvent {}

class BottomSheetStarted extends HomeEvent {
  final bool isBottomSheetOpened;
  BottomSheetStarted(this.isBottomSheetOpened);
}

class HomeClose extends HomeEvent {}
