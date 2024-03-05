import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/utils/toast_ulti.dart';
import 'package:cleaning_duty_project/feature/blocs/authenticate/login/bloc/login_bloc.dart';
import 'package:cleaning_duty_project/feature/routers/screen_route.dart';
import 'package:cleaning_duty_project/feature/widget/Button/common_button.dart';
import 'package:cleaning_duty_project/feature/widget/TextField/common_text_field.dart';
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
  @override
  Widget build(BuildContext context) {
    final loginState = context.watch<LoginBloc>().state;

    var loginWidget = (switch (loginState) {
      LoginInitial() => _buildInitialLoginWidget(
          context,
          context.read<LoginBloc>().usernameController,
          context.read<LoginBloc>().passwordController,
          context.read<LoginBloc>().isDisable),
      LoginProgress() => _buildInitialLoginWidget(
          context,
          context.read<LoginBloc>().usernameController,
          context.read<LoginBloc>().passwordController,
          context.read<LoginBloc>().isDisable),
      LoginFailure() => _buildInitialLoginWidget(
          context,
          context.read<LoginBloc>().usernameController,
          context.read<LoginBloc>().passwordController,
          context.read<LoginBloc>().isDisable),
      LoginSuccess() => const SizedBox(),
    });

    loginWidget = BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginProgress) {
          context.read<LoginBloc>().isDisable = true;
        }
        if (state is LoginSuccess) {
          context.read<LoginBloc>().isDisable = false;
          ToastUtil.showSuccessMessage("Login Successfully");
          context.go(ScreenRoute.homeScreen);
        }
        if (state is LoginFailure) {
          context.read<LoginBloc>().isDisable = false;
          ToastUtil.showErrorMessage("Login Failed");
        }
      },
      child: loginWidget,
    );

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
                    loginWidget,
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
        ),
      ),
    );
  }
}

Widget _buildInitialLoginWidget(
    BuildContext context,
    TextEditingController usernameController,
    TextEditingController passwordController,
    bool isDisable) {
  return Column(
    children: [
      SizedBox(height: 30.h),
      CommonTextField(
          label: 'Username',
          inputController: usernameController,
          isDisable: isDisable),
      SizedBox(height: 20.h),
      CommonTextField(
          isPassword: true,
          label: 'Password',
          inputController: passwordController,
          isDisable: isDisable),
      SizedBox(height: 20.h),
      CommonButton(
        isDisable: isDisable,
        buttonText: 'Login',
        onPressedFunction: () {
          context
              .read<LoginBloc>()
              .handleLogin(context, usernameController, passwordController);
        },
      ),
    ],
  );
}
