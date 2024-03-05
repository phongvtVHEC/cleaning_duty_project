part of 'bottom_sheet_bloc.dart';

class BottomSheetEvent {}

class BottomSheetStarted extends BottomSheetEvent {
  final bool isOpened;

  BottomSheetStarted(this.isOpened);
}
