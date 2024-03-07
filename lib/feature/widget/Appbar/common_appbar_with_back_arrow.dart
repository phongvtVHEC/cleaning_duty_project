import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonAppbarWithBackArrow extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final void Function()? onPressedBackButton;
  const CommonAppbarWithBackArrow({
    super.key,
    required this.title,
    this.onPressedBackButton,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.0.h,
      child: Container(
        alignment: Alignment.center,
        color: AppColor.colorAppBar,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColor.colorWhite,
                      size: 20.sp,
                    ),
                    onPressed: onPressedBackButton,
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: AppColor.colorWhite,
                  fontFamily: Constants.app_font_Lato,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(160.sp);
}
