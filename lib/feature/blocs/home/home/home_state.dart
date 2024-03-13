part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeReset extends HomeState {}

final class BottomSheetOpened extends HomeState {}

final class BottomSheetClosed extends HomeState {}

final class DateBarUpdated extends HomeState {}
