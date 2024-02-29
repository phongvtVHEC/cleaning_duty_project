import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/feature/routers/screen_route.dart';
import 'package:cleaning_duty_project/feature/widget/common_button.dart';
import 'package:cleaning_duty_project/feature/widget/common_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 200.h),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'LOGIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.colorBlack,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Input the right details to login the right way.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF737C96),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CommonTextField(
                        label: 'Username', inputController: usernameController),
                    SizedBox(
                      height: 20.h,
                    ),
                    CommonTextField(
                        label: 'Password', inputController: passwordController),
                    SizedBox(
                      height: 20.h,
                    ),
                    CommonButton(
                      buttonText: 'Login',
                      onPressedFunction: () {},
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Dont have an account? ',
                            style: TextStyle(
                              color: AppColor.colorFontBlack,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.push(ScreenRoute.registerScreen);
                              },
                            text: 'Register',
                            style: TextStyle(
                              color: AppColor.colorBlack,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
