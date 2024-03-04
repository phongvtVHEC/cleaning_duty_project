part of 'home_bloc.dart';

class HomeEvent {}

class BottomSheetEvent extends HomeEvent {
  final bool isOpened;

  BottomSheetEvent({
    required this.isOpened,
  });
}
