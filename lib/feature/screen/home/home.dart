import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/utils/toast_ulti.dart';
import 'package:cleaning_duty_project/feature/blocs/authenticate/logout/bloc/logout_bloc.dart';
import 'package:cleaning_duty_project/feature/blocs/home/home/home_bloc.dart';
import 'package:cleaning_duty_project/feature/routers/screen_route.dart';
import 'package:cleaning_duty_project/feature/widget/Calendar/common_calendar.dart';
import 'package:cleaning_duty_project/feature/widget/DateBar/common_appbar_with_date_bar.dart';
import 'package:cleaning_duty_project/feature/widget/BottomSheetActionBar/common_bottom_sheet_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorWhite,
      key: context.read<HomeBloc>().key,
      drawer: BlocListener<LogoutBloc, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            ToastUtil.showSuccessMessage('Logout success!');
            context.pushReplacement(ScreenRoute.loginScreen);
          }
          if (state is LogoutFailure) {
            ToastUtil.showErrorMessage('Logout failure!');
          }
        },
        child: Drawer(
          backgroundColor: AppColor.colorWhite,
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  title: const Text('Information'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Logout'),
                  onTap: () {
                    BlocProvider.of<LogoutBloc>(context).handleLogout(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: CommonAppbarWithDateBar(
        globalKey: context.read<HomeBloc>().key,
        year: '2021',
        month: 'June',
        onPressBack: () {
          context
              .read<HomeBloc>()
              .calendarKey
              .currentState!
              .onPressBackFunction();
        },
        onPressForward: () {
          context
              .read<HomeBloc>()
              .calendarKey
              .currentState!
              .onPressForwardFunction();
        },
      ),
      bottomSheet: const CommonBottomSheetActionBar(),
      body: const CommonCalendar(),
    );
  }
}
