import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/utils/toast_ulti.dart';
import 'package:cleaning_duty_project/feature/blocs/authenticate/login/bloc/login_bloc.dart';
import 'package:cleaning_duty_project/feature/data/entities/request/authentication/login/login_request.dart';
import 'package:cleaning_duty_project/feature/routers/screen_route.dart';
import 'package:cleaning_duty_project/feature/widget/common_button.dart';
import 'package:cleaning_duty_project/feature/widget/common_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _handleLogin(BuildContext context) {
    context.read<LoginBloc>().add(
          LoginStarted(
            loginRequest: LoginRequest(
              username: usernameController.text,
              password: passwordController.text,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ToastUtil.showSuccessMessage("Login Successfully");
              context.go(ScreenRoute.homeScreen);
            }
            if (state is LoginFailure) {
              ToastUtil.showErrorMessage("Login Failed");
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              final child = (switch (state) {
                LoginInitial() => _buildInitialLoginWidget(
                    usernameController, passwordController),
                LoginProgress() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                LoginFailure() => _buildInitialLoginWidget(
                    usernameController, passwordController),
                LoginSuccess() => const Text('Login Success'),
              });
              return Column(
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
                          child,
                          CommonButton(
                            buttonText: 'Login',
                            onPressedFunction: () {
                              _handleLogin(context);
                            },
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
                                      context.go(ScreenRoute.registerScreen);
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
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildInitialLoginWidget(TextEditingController usernameController,
    TextEditingController passwordController) {
  return Column(
    children: [
      SizedBox(height: 30.h),
      CommonTextField(label: 'Username', inputController: usernameController),
      SizedBox(height: 20.h),
      CommonTextField(label: 'Password', inputController: passwordController),
      SizedBox(height: 20.h),
    ],
  );
}
