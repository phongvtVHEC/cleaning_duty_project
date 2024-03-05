import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cleaning_duty_project/core/colors/app_color.dart';

class CommonButtonDateCircle extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;
  const CommonButtonDateCircle({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: 35.w,
        height: 35.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 30.w,
              height: 25.h,
              decoration: ShapeDecoration(
                color: AppColor.colorButtonCircleDate,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x2BCECECE),
                    blurRadius: 20,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
            ),
            Icon(
              icon,
              size: 12.sp,
              color: AppColor.colorFont0D8BFF,
            ),
          ],
        ),
      ),
    );
  }
}
