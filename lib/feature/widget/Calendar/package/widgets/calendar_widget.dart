// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, curly_braces_in_flow_control_structures

import 'package:cleaning_duty_project/feature/data/entities/response/cleanning_duty/cleanning_duties_response.dart';
import 'package:cleaning_duty_project/feature/widget/Calendar/package/models/date.dart';
import 'package:cleaning_duty_project/feature/widget/Calendar/package/models/day.dart';
import 'package:cleaning_duty_project/feature/widget/Calendar/package/widgets/day_widget.dart';
import 'package:flutter/material.dart';

import 'controller.dart';

class CalendarWidget extends StatefulWidget {
  final Date? date;
  final Color? activeColor;
  final Color? backgroundColor;
  final TextStyle? selectedStyle;
  final TextStyle? textStyleDays;
  final TextStyle? textStyleWeekDay;
  final TextStyle? titleStyle;
  final ValueChanged<Date>? onSelected;
  final PageController? pageController;
  final Widget? previous;
  final Widget? next;
  final bool? weekendOpacityEnable;
  final double? weekendOpacity;
  final List<CleaningDutiesResponse> cleaningDutyList;
  const CalendarWidget(
      {Key? key,
      this.activeColor,
      this.textStyleDays,
      this.textStyleWeekDay,
      this.onSelected,
      this.backgroundColor,
      required this.date,
      this.previous,
      this.next,
      this.pageController,
      this.titleStyle,
      this.selectedStyle,
      this.weekendOpacityEnable,
      this.weekendOpacity,
      required this.cleaningDutyList})
      : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late Controller _controller;
  var daySelected;
  @override
  void initState() {
    final dateNow = DateTime.now();
    if (dateNow.month == widget.date!.month &&
        dateNow.year == widget.date!.year)
      daySelected = Day(
          value: dateNow.day,
          weekDay: dateNow.weekday,
          date: Date(
              day: dateNow.day,
              month: widget.date!.month,
              year: widget.date!.year));

    _controller =
        Controller(month: widget.date!.month, year: widget.date!.year);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Column(
        children: [
          Table(
            children: [
              ..._controller.list
                  .map((week) => TableRow(
                      children: week
                          .map((day) => DayWidget(
                                cleaningDutyList: widget.cleaningDutyList,
                                date: day.dateTime,
                                day: day,
                                isSelected: daySelected == day,
                                style: daySelected == day
                                    ? widget.selectedStyle
                                    : widget.weekendOpacityEnable! &&
                                            day.isWeekend
                                        ? widget.textStyleDays!.copyWith(
                                            color: Colors.red,
                                          )
                                        : widget.textStyleDays,
                                activeColor: widget.activeColor,
                                backgroundColor: widget.backgroundColor,
                                onTap: () {
                                  if (widget.onSelected != null) {
                                    widget.onSelected!(Date(
                                        day: day.value,
                                        month: widget.date!.month,
                                        year: widget.date!.year));
                                    if (day == daySelected) {
                                      daySelected = null;
                                    } else {
                                      daySelected = day;
                                    }

                                    setState(() {});
                                  }
                                },
                              ))
                          .toList()))
                  .toList()
            ],
          ),
        ],
      ),
    );
  }
}
