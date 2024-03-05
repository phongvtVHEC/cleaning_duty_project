part of 'bottom_sheet_bloc.dart';

sealed class BottomSheetState {}

final class BottomSheetInitial extends BottomSheetState {}

final class BottomSheetOpened extends BottomSheetState {}

final class BottomSheetClosed extends BottomSheetState {}
