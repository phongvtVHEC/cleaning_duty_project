part of 'cleanning_duty_bloc.dart';

sealed class CleanningDutyState {}

final class CleanningDutyInitial extends CleanningDutyState {}

final class CleanningDutyProgress extends CleanningDutyState {}

final class CleanningDutySuccess extends CleanningDutyState {}

final class CleanningDutyFailure extends CleanningDutyState {}
