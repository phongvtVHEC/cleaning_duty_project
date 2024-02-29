import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressedFunction;

  const CommonButton(
      {super.key, required this.buttonText, this.onPressedFunction});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: InkWell(
        onTap: onPressedFunction,
        child: Container(
          decoration: ShapeDecoration(
            color: const Color(0xFF337EEE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.sp),
            child: Center(
              child: Text(
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
    );
  }
}
