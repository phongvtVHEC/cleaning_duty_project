import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/core/utils/toast_ulti.dart';
import 'package:cleaning_duty_project/feature/blocs/authenticate/logout/bloc/logout_bloc.dart';
import 'package:cleaning_duty_project/feature/blocs/home/bottom_sheet/bottom_sheet_bloc.dart';
import 'package:cleaning_duty_project/feature/blocs/home/home/home_bloc.dart';
import 'package:cleaning_duty_project/feature/routers/screen_route.dart';
import 'package:cleaning_duty_project/feature/widget/BottomSheetActionBar/smoothness.dart';
import 'package:cleaning_duty_project/feature/widget/BottomSheetActionBar/solidBottomSheet.dart';
import 'package:cleaning_duty_project/feature/widget/Calendar/calendar_page.dart';
import 'package:cleaning_duty_project/feature/widget/common_appbar_with_date_bar.dart';
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
    Widget bottomSheetIcon =
        Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 30.sp);
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
      bottomSheet: BlocListener<BottomSheetBloc, BottomSheetState>(
        listener: (context, state) {
          if (state is BottomSheetOpened) {
            bottomSheetIcon = Icon(Icons.keyboard_arrow_down,
                color: Colors.white, size: 30.sp);
          }
          if (state is BottomSheetClosed) {
            bottomSheetIcon =
                Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 30.sp);
          }
        },
        child: BlocBuilder<BottomSheetBloc, BottomSheetState>(
          builder: (context, state) {
            return SolidBottomSheet(
              controller: context.read<BottomSheetBloc>().solidController,
              onShow: () {
                context
                    .read<BottomSheetBloc>()
                    .handleBottomSheetOpened(context);
              },
              onHide: () {
                context
                    .read<BottomSheetBloc>()
                    .handleBottomSheetClosed(context);
              },
              toggleVisibilityOnTap: true,
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
                    bottomSheetIcon,
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
                color: AppColor.colorAppBar,
              ),
            );
          },
        ),
      ),
      body: Calendar(
        key: context.read<HomeBloc>().calendarKey,
        disable: false,
        initialDate: DateTime.now(),
        weekendOpacityEnable: true,
        space: 20,
        onSelected: print,
        backgroundColor: Colors.white,
        activeColor: Colors.orange,
        textStyleDays:
            const TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
        textStyleWeekDay: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 9.sp),
        selectedStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
