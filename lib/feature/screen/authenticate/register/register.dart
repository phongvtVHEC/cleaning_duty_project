import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/feature/blocs/authenticate/register/bloc/register_bloc.dart';
import 'package:cleaning_duty_project/feature/routers/screen_route.dart';
import 'package:cleaning_duty_project/feature/widget/common_button.dart';
import 'package:cleaning_duty_project/feature/widget/common_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          final child = (switch (state) {
            RegisterInitial() => _buildInitialRegister(
                emailController,
                usernameController,
                passwordController,
                confirmPasswordController),
            RegisterProgress() =>
              const Center(child: CircularProgressIndicator()),
            RegisterSuccess() => const Text('Register Success'),
            RegisterFailure() => _buildInitialRegister(
                emailController,
                usernameController,
                passwordController,
                confirmPasswordController),
          });
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100.h),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'REGISTER',
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
                        'Input the right details to register the right way.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF737C96),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // child,
                      CommonButton(
                        buttonText: 'Register',
                        onPressedFunction: () {},
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                color: AppColor.colorFontBlack,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go(ScreenRoute.loginScreen);
                                },
                              text: 'Login',
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
          );
        },
      ),
    );
  }
}

Widget _buildInitialRegister(
    TextEditingController emailController,
    TextEditingController usernameController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController) {
  return Column(
    children: [
      SizedBox(height: 30.h),
      CommonTextField(
        label: 'Email',
        inputController: emailController,
      ),
      SizedBox(height: 20.h),
      CommonTextField(label: 'Username', inputController: usernameController),
      SizedBox(height: 20.h),
      CommonTextField(
        label: 'Password',
        inputController: passwordController,
      ),
      SizedBox(height: 20.h),
      CommonTextField(
          label: 'Confirm Password',
          inputController: confirmPasswordController),
      SizedBox(height: 20.h),
    ],
  );
}
