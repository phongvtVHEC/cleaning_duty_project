import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/feature/routers/screen_route.dart';
import 'package:cleaning_duty_project/feature/widget/common_button.dart';
import 'package:cleaning_duty_project/feature/widget/common_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
              padding: const EdgeInsets.only(top: 200),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'LOGIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.colorBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Input the right details to login the right way.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF737C96),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CommonTextField(
                        label: 'Username', inputController: usernameController),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonTextField(
                        label: 'Password', inputController: passwordController),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonButton(
                      buttonText: 'Login',
                      onPressedFunction: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Dont have an account? ',
                            style: TextStyle(
                              color: AppColor.colorFontBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.push(ScreenRoute.registerScreen);
                              },
                            text: 'Register',
                            style: const TextStyle(
                              color: AppColor.colorBlack,
                              fontSize: 14,
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
