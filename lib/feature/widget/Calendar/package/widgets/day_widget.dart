import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/feature/data/entities/response/cleanning_duty/cleanning_duties_response.dart';
import 'package:cleaning_duty_project/feature/widget/Calendar/package/models/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayWidget extends StatelessWidget {
  final Day? day;
  final DateTime? date;
  final TextStyle? style;
  final Color? activeColor;
  final Color? backgroundColor;
  final Function? onTap;
  final bool isSelected;
  final double radius;
  final List<CleaningDutiesResponse> cleaningDutyList;

  const DayWidget(
      {Key? key,
      this.day,
      this.style,
      this.onTap,
      this.activeColor,
      this.isSelected = false,
      this.radius = 20,
      this.backgroundColor,
      this.date,
      required this.cleaningDutyList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isCurrentDay = day!.value == date!.day;
    final bool isCurrentMonth = day!.date!.month == date!.month;
    final bool isCurrentYear = day!.date!.year == date!.year;
    // Default avatar
    String avatarUrl = "";
    for (var element in cleaningDutyList) {
      if (DateTime.tryParse(element.assignDate ?? '')!.day == day!.value &&
          DateTime.tryParse(element.assignDate ?? '')!.month == date!.month) {
        avatarUrl = element.cleaner!.avatarUrl ?? "";
      }
    }
    return GestureDetector(
      onTap: day!.value == 0 ? null : onTap as void Function()?,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF0D8BFF)
                    : (backgroundColor ?? Colors.transparent),
              ),
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              day!.label,
              textAlign: TextAlign.center,
              style: (isCurrentDay && isCurrentMonth && isCurrentYear) &&
                      !isSelected
                  ? (style!.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFFFFC700),
                      decorationThickness: 2.0,
                    ))
                  : style,
            ),
          ),
          Visibility(
            visible: day!.isWeekend == false && day!.value != 0,
            child: Positioned(
              bottom: 0,
              right: 0,
              width: 20.sp,
              height: 20.sp,
              child: Center(
                child: avatarUrl.isNotEmpty
                    ? Container(
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(avatarUrl),
                            fit: BoxFit.cover,
                          ),
                          shape: const OvalBorder(
                            side:
                                BorderSide(width: 1, color: AppColor.colorGrey),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
