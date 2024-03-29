import 'package:cleaning_duty_project/feature/widget/Calendar/package/models/date.dart';

class Day {
  final int? value;
  final int? weekDay;
  final Date? date;
  final DateTime? dateTime;

  @override
  String toString() => value == 0 ? "" : "$value";

  String get label => value == 0 ? "" : "$value";

  bool get isWeekend => weekDay == 0 || weekDay == 6;

  Day({this.date, this.value, this.weekDay})
      : dateTime = date != null ? DateTime.now() : null;

  @override
  int get hashCode => date.hashCode;

  @override
  operator ==(other) => other.hashCode == hashCode;
}
