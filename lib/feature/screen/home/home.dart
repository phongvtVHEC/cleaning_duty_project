import 'package:cleaning_duty_project/core/utils/toast_ulti.dart';
import 'package:cleaning_duty_project/feature/blocs/authenticate/logout/bloc/logout_bloc.dart';
import 'package:cleaning_duty_project/feature/routers/screen_route.dart';
import 'package:cleaning_duty_project/feature/widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDisable = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.pushReplacement(ScreenRoute.loginScreen);
        }
        if (state is LogoutProgress) {
          isDisable = true;
        }
        if (state is LogoutFailure) {
          ToastUtil.showErrorMessage('Logout Failed');
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text('This is Home Screen'),
            ),
            CommonButton(
              isDisable: isDisable,
              buttonText: 'LogOut',
              onPressedFunction: () =>
                  context.read<LogoutBloc>().handleLogout(context),
            )
          ],
        ),
      ),
    );
  }
}
