import 'package:cleaning_duty_project/feature/widget/Calendar/package/models/day.dart';
import 'package:cleaning_duty_project/feature/widget/Calendar/package/service.dart';

class Controller {
  final _service = Service();

  final int? month;

  final int? year;

  late List<List<Day>> list;

  Controller({this.month, this.year}) {
    generate();
  }

  void generate() {
    list = _service.getDaysInMonth(month: month!, year: year!);
  }
}
