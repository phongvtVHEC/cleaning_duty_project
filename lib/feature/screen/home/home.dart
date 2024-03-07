import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/core/utils/toast_ulti.dart';
import 'package:cleaning_duty_project/feature/blocs/authenticate/logout/bloc/logout_bloc.dart';
import 'package:cleaning_duty_project/feature/blocs/home/home/home_bloc.dart';
import 'package:cleaning_duty_project/feature/routers/screen_route.dart';
import 'package:cleaning_duty_project/feature/widget/BottomSheetActionBar/package/smoothness.dart';
import 'package:cleaning_duty_project/feature/widget/BottomSheetActionBar/package/solidBottomSheet.dart';
import 'package:cleaning_duty_project/feature/widget/Calendar/common_calendar.dart';
import 'package:cleaning_duty_project/feature/widget/Appbar/common_appbar_with_date_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorWhite,
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
      bottomSheet: _buidlBottomSheet(context),
      body: const CommonCalendar(),
    );
  }
}

_buidlBottomSheet(BuildContext context) {
  var logoutState = context.watch<LogoutBloc>().state;
  if (logoutState is LogoutSuccess) {
    ToastUtil.showSuccessMessage('Logout success!');
    context.pushReplacement(ScreenRoute.loginScreen);
  }

  return SolidBottomSheet(
    controller: context.read<HomeBloc>().solidController,
    onShow: () {
      context.read<HomeBloc>().handleBottomSheetOpened(context);
    },
    onHide: () {
      context.read<HomeBloc>().handleBottomSheetClosed(context);
    },
    toggleVisibilityOnTap: true,
    canUserSwipe: false,
    draggableBody: false,
    maxHeight: 400.h,
    smoothness: Smoothness.medium,
    headerBar: Container(
      decoration: const BoxDecoration(
        color: AppColor.colorAppBar,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      height: 93.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 5.h,
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              Icon? bottomSheetIcon;
              if (state is HomeInitial) {
                bottomSheetIcon = Icon(Icons.keyboard_arrow_up,
                    color: Colors.white, size: 30.sp);
              }
              if (state is BottomSheetOpened) {
                bottomSheetIcon = Icon(Icons.keyboard_arrow_down,
                    color: Colors.white, size: 30.sp);
              }
              if (state is BottomSheetClosed) {
                bottomSheetIcon = Icon(Icons.keyboard_arrow_up,
                    color: Colors.white, size: 30.sp);
              }
              if (state is HomeReset) {
                bottomSheetIcon = Icon(Icons.keyboard_arrow_up,
                    color: Colors.white, size: 30.sp);
              }
              return bottomSheetIcon ?? Container();
            },
          ),
          Text(
            'Quick actions',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              fontFamily: Constants.app_font_Lato,
            ),
          ),
        ],
      ),
    ),
    body: Container(
      height: double.infinity,
      color: AppColor.colorAppBar,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<HomeBloc>().resetState(context);
                        context.push(ScreenRoute.profileScreen);
                      },
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: Constants.app_font_Lato,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.person_add,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                    Text(
                      'Add member',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: Constants.app_font_Lato,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<LogoutBloc>().handleLogout(context);
                      },
                      icon: Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: Constants.app_font_Lato,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
