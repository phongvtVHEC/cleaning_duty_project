import 'package:cleaning_duty_project/core/utils/toast_util.dart';
import 'package:cleaning_duty_project/core/utils/validation_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/feature/blocs/authenticate/login/bloc/login_bloc.dart';
import 'package:cleaning_duty_project/feature/routers/screen_route.dart';
import 'package:cleaning_duty_project/feature/widget/button/common_button.dart';
import 'package:cleaning_duty_project/feature/widget/textfield/common_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 200.h),
                  child: Center(
                    child: Column(
                      children: [
                        Column(
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
                            SizedBox(height: 10.h),
                            Text(
                              'Input the right details to login the right way.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF737C96),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        _buildLoginWidget(context),
                        SizedBox(height: 20.h),
                        SizedBox(
                          height: 20.h,
                          child: Text.rich(
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoginWidget(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return BlocListener<LoginBloc, LoginState>(
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
        if (state is ValidatorDone) {
          context.read<LoginBloc>().isDisable = false;
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 30.h),
            CommonTextField(
              maxLines: 1,
              label: 'Username',
              inputController: loginBloc.usernameController,
              errorText: loginBloc.errorUsername != ""
                  ? loginBloc.errorUsername
                  : null,
              isDisable: loginBloc.isDisable,
              onChanged: (value) {
                ValidateUtil.cleanErrorText(loginBloc.errorUsername);
                context
                    .read<LoginBloc>()
                    .add(CleanErrorFields(field: 'username'));
              },
            ),
            SizedBox(height: 15.h),
            CommonTextField(
              maxLines: 1,
              isPassword: true,
              label: 'Password',
              inputController: loginBloc.passwordController,
              errorText: loginBloc.errorPassword != ""
                  ? loginBloc.errorPassword
                  : null,
              isDisable: loginBloc.isDisable,
              onChanged: (value) {
                ValidateUtil.cleanErrorText(loginBloc.errorUsername);
                context
                    .read<LoginBloc>()
                    .add(CleanErrorFields(field: 'password'));
              },
            ),
            SizedBox(height: 15.h),
            CommonButton(
              isDisable: loginBloc.isDisable,
              buttonText: 'Login',
              onPressedFunction: () {
                loginBloc.handleLogin(context, loginBloc.usernameController,
                    loginBloc.passwordController);
              },
            ),
          ],
        ),
      ),
    );
  }
}
