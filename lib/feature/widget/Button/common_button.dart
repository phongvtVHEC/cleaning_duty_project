import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressedFunction;
  final bool? isDisable;

  const CommonButton({
    Key? key,
    required this.buttonText,
    required this.onPressedFunction,
    this.isDisable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Stack(
        children: [
          IgnorePointer(
            ignoring: isDisable ?? false,
            child: InkWell(
              onTap: onPressedFunction,
              child: Container(
                decoration: ShapeDecoration(
                  color: isDisable ?? false ? Colors.grey : Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.sp),
                  child: Center(
                    child: isDisable ?? false
                        ? SizedBox(
                            height: 20.sp,
                            width: 20.sp,
                            child: const CircularProgressIndicator(
                              color: AppColor.colorWhite,
                            ))
                        : Text(
                            buttonText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
