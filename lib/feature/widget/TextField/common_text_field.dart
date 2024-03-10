// ignore_for_file: unrelated_type_equality_checks

import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? inputController;
  final bool? isDisable;
  final bool? isPassword;
  final Color? textFieldColor;
  final Color? textColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final int? maxLines;
  final TextAlign? textAlign;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? errorText;

  const CommonTextField({
    Key? key,
    this.label,
    this.inputController,
    this.isDisable,
    this.textFieldColor,
    this.isPassword,
    this.keyboardType,
    this.textInputAction,
    this.onEditingComplete,
    this.inputFormatters,
    this.onChanged,
    this.maxLength,
    this.maxLines,
    this.textAlign,
    this.hintText,
    this.hintStyle,
    this.errorText,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            IgnorePointer(
              ignoring: isDisable ?? false,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(
                      color: textColor ?? Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    cursorColor: AppColor.colorTextFieldLabel,
                    keyboardType: (keyboardType != null && keyboardType != '')
                        ? keyboardType
                        : TextInputType.multiline,
                    textInputAction: textInputAction ?? TextInputAction.newline,
                    onEditingComplete: onEditingComplete ??
                        () {
                          FocusScope.of(context).nextFocus();
                        },
                    inputFormatters: inputFormatters,
                    obscureText: isPassword ?? false,
                    enableInteractiveSelection:
                        isDisable == true ? false : true,
                    readOnly: isDisable ?? false,
                    controller: inputController,
                    onChanged: onChanged,
                    maxLength: maxLength,
                    maxLines: maxLines,
                    textAlign: (textAlign != null && textAlign != "")
                        ? textAlign!
                        : TextAlign.start,
                    decoration: InputDecoration(
                      labelText: label,
                      labelStyle: TextStyle(
                        color: errorText == null
                            ? AppColor.colorTextFieldLabel
                            : AppColor.colorD60000,
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
                      fillColor: (errorText != null && errorText != "")
                          ? AppColor.colorFFE7E7
                          : AppColor.colorWhite,
                      hintText:
                          (hintText != null && hintText != "") ? hintText : '',
                      hintStyle: (hintStyle != null && hintStyle != "")
                          ? hintStyle
                          : null,
                    ),
                  ),
                  (errorText != null && errorText != "")
                      ? Padding(
                          padding: EdgeInsets.only(top: 4.sp),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(right: 5.sp, top: 2.sp),
                                child: Icon(
                                  Icons.warning,
                                  color: AppColor.colorD60000,
                                  size: 16.sp,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  errorText ?? "",
                                  style: TextStyle(
                                      color: AppColor.colorD60000,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
