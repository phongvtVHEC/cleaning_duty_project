import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/feature/widget/common_button_date_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonDateBar extends StatelessWidget {
  const CommonDateBar({
    super.key,
    required this.month,
    required this.year,
    this.onPressedForward,
    this.onPressedBack,
  });

  final String month;
  final String year;
  final Function()? onPressedForward;
  final Function()? onPressedBack;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80.0.h,
      left: 0.0.w,
      right: 0.0.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
        child: Container(
          height: 50.h,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23.50.sp),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F78C7F3),
                blurRadius: 20,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CommonButtonDateCircle(
                icon: Icons.arrow_back_ios_new_outlined,
                onPressed: onPressedBack,
              ),
              Row(
                children: [
                  Text(
                    month,
                    style: const TextStyle(
                      color: AppColor.colorFont0857A0,
                      fontSize: 16,
                      fontFamily: Constants.app_font_Lato,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    year,
                    style: const TextStyle(
                      color: Color(0xFF010F1B),
                      fontSize: 16,
                      fontFamily: Constants.app_font_Lato,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              CommonButtonDateCircle(
                icon: Icons.arrow_forward_ios_outlined,
                onPressed: onPressedForward,
              )
            ],
          ),
        ),
      ),
    );
  }
}
