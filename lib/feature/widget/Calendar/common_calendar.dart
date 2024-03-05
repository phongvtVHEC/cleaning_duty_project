import 'package:cleaning_duty_project/feature/blocs/home/home/home_bloc.dart';
import 'package:cleaning_duty_project/feature/widget/Calendar/package/calendar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonCalendar extends StatelessWidget {
  const CommonCalendar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Calendar(
      key: context.read<HomeBloc>().calendarKey,
      disable: false,
      initialDate: DateTime.now(),
      weekendOpacityEnable: true,
      space: 20,
      onSelected: print,
      backgroundColor: Colors.white,
      activeColor: Colors.orange,
      textStyleDays:
          const TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
      textStyleWeekDay: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 9.sp),
      selectedStyle:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}
