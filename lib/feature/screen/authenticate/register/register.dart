import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/utils/toast_ulti.dart';
import 'package:cleaning_duty_project/core/utils/validation_ulti.dart';
import 'package:cleaning_duty_project/feature/blocs/authenticate/register/bloc/register_bloc.dart';
import 'package:cleaning_duty_project/feature/routers/screen_route.dart';
import 'package:cleaning_duty_project/feature/widget/Button/common_button.dart';
import 'package:cleaning_duty_project/feature/widget/TextField/common_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var registerState = context.watch<RegisterBloc>().state;
    if (registerState is RegisterSuccess) {
      ToastUtil.showSuccessMessage('Register success');
      context.pushReplacement(ScreenRoute.homeScreen);
    }
    if (registerState is RegisterFailure) {
      ToastUtil.showErrorMessage('Register failure');
    }
    if (registerState is ValidatorDone) {
      context.read<RegisterBloc>().isDisable = false;
    }
    return Scaffold(
      body: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 100.h),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                          SizedBox(height: 10.h),
                          Text(
                            'Input the right details to register the right way.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF737C96),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          _buildInitialRegisterUI(context),
                          CommonButton(
                            buttonText: 'Register',
                            onPressedFunction: () {
                              context.read<RegisterBloc>().handleRegister(
                                    context,
                                    context
                                        .read<RegisterBloc>()
                                        .usernameController,
                                    context
                                        .read<RegisterBloc>()
                                        .passwordController,
                                    context
                                        .read<RegisterBloc>()
                                        .emailController,
                                  );
                            },
                            isDisable: context.read<RegisterBloc>().isDisable,
                          ),
                          SizedBox(height: 20.h),
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
                                      context.pushReplacement(
                                          ScreenRoute.loginScreen);
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
                          SizedBox(height: 40.h),
                        ],
                      ),
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
}

Widget _buildInitialRegisterUI(BuildContext context) {
  return Column(
    children: [
      SizedBox(height: 30.h),
      CommonTextField(
        maxLines: 1,
        label: 'Email',
        inputController: context.read<RegisterBloc>().emailController,
        errorText: context.read<RegisterBloc>().errorEmail != ""
            ? context.read<RegisterBloc>().errorEmail
            : null,
        onChanged: (value) {
          ValidateUtil.cleanErrorText(context.read<RegisterBloc>().errorEmail);
          context.read<RegisterBloc>().add(CleanErrorField(field: 'email'));
        },
        isDisable: context.read<RegisterBloc>().isDisable,
      ),
      SizedBox(height: 15.h),
      CommonTextField(
        maxLines: 1,
        label: 'Username',
        inputController: context.read<RegisterBloc>().usernameController,
        errorText: context.read<RegisterBloc>().errorUsername != ""
            ? context.read<RegisterBloc>().errorUsername
            : null,
        onChanged: (value) {
          ValidateUtil.cleanErrorText(
              context.read<RegisterBloc>().usernameController.text);
          context.read<RegisterBloc>().add(CleanErrorField(field: 'username'));
        },
        isDisable: context.read<RegisterBloc>().isDisable,
      ),
      SizedBox(height: 15.h),
      CommonTextField(
        isPassword: true,
        maxLines: 1,
        label: 'Password',
        inputController: context.read<RegisterBloc>().passwordController,
        errorText: context.read<RegisterBloc>().errorPassword != ""
            ? context.read<RegisterBloc>().errorPassword
            : null,
        onChanged: (value) {
          ValidateUtil.cleanErrorText(
              context.read<RegisterBloc>().passwordController.text);
          context.read<RegisterBloc>().add(CleanErrorField(field: 'password'));
        },
        isDisable: context.read<RegisterBloc>().isDisable,
      ),
      SizedBox(height: 15.h),
      CommonTextField(
        maxLines: 1,
        isPassword: true,
        label: 'Confirm Password',
        inputController: context.read<RegisterBloc>().confirmPasswordController,
        errorText: context.read<RegisterBloc>().errorPasswordConfirm != ""
            ? context.read<RegisterBloc>().errorPasswordConfirm
            : null,
        onChanged: (value) {
          ValidateUtil.cleanErrorText(
              context.read<RegisterBloc>().confirmPasswordController.text);
          context
              .read<RegisterBloc>()
              .add(CleanErrorField(field: 'passwordConfirm'));
        },
        isDisable: context.read<RegisterBloc>().isDisable,
      ),
      SizedBox(height: 20.h),
    ],
  );
}
