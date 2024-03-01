import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextField extends StatelessWidget {
  final String label;
  final TextEditingController? inputController;
  final bool? isDisable;
  final bool? isPassword;
  final Color? textFieldColor;
  const CommonTextField({
    Key? key,
    required this.label,
    this.inputController,
    this.isDisable,
    this.textFieldColor,
    this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 335.w,
          height: 59.h,
          child: Stack(
            children: [
              IgnorePointer(
                ignoring: isDisable ?? false,
                child: TextField(
                  obscureText: isPassword ?? false,
                  enableInteractiveSelection: isDisable == true ? false : true,
                  readOnly: isDisable ?? false,
                  controller: inputController,
                  decoration: InputDecoration(
                    labelText: label,
                    labelStyle: TextStyle(
                      color: AppColor.colorTextFieldLabel,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.w, color: AppColor.colorTextFieldBorder),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.w, color: AppColor.colorTextFieldBorder),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: isDisable == true
                        ? AppColor.colorTextFieldDisable
                        : textFieldColor ?? AppColor.colorWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
