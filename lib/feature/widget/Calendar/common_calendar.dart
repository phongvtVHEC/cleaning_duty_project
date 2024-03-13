import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/feature/blocs/home/home/home_bloc.dart';
import 'package:cleaning_duty_project/feature/widget/Calendar/package/calendar_page.dart';
import 'package:cleaning_duty_project/feature/widget/Calendar/package/models/date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonCalendar extends StatelessWidget {
  final void Function(Date?) funtionOnTapDate;
  const CommonCalendar({
    super.key,
    required this.funtionOnTapDate,
  });

  @override
  Widget build(BuildContext context) {
    return Calendar(
      key: context.read<HomeBloc>().calendarKey,
      disable: false,
      initialDate: DateTime.now(),
      weekendOpacityEnable: true,
      space: 20,
      onSelected: funtionOnTapDate,
      backgroundColor: Colors.white,
      activeColor: Colors.orange,
      textStyleDays: TextStyle(
          fontWeight: FontWeight.normal, color: Colors.black, fontSize: 18.sp),
      textStyleWeekDay: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 15.sp,
          fontFamily: Constants.app_font_Lato),
      selectedStyle: TextStyle(
          fontWeight: FontWeight.normal,
          color: AppColor.colorFont0D8BFF,
          fontSize: 18.sp),
    );
  }
}
