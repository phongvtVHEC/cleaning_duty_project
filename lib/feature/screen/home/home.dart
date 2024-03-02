import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/utils/toast_ulti.dart';
import 'package:cleaning_duty_project/feature/blocs/authenticate/logout/bloc/logout_bloc.dart';
import 'package:cleaning_duty_project/feature/routers/screen_route.dart';
import 'package:cleaning_duty_project/feature/widget/Calendar/calendar_page.dart';
import 'package:cleaning_duty_project/feature/widget/common_appbar_with_date_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool isDisable = false;
  void Function()? onPressBack;
  void Function()? onPressForward;

  @override
  void initState() {
    super.initState();
  }

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
        backgroundColor: AppColor.colorWhite,
        key: _key,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  BlocProvider.of<LogoutBloc>(context).add(LogoutEvent());
                },
              ),
            ],
          ),
        ),
        appBar: CommonAppbarWithDateBar(
          globalKey: _key,
          year: '2021',
          month: 'June',
          onPressBack: () => onPressBack,
          onPressForward: () => onPressForward,
        ),
        bottomSheet: SolidBottomSheet(
          toggleVisibilityOnTap: true,
          canUserSwipe: false,
          draggableBody: true,
          maxHeight: 400.h,
          smoothness: Smoothness.high,
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
                Icon(Icons.expand_less_rounded,
                    color: Colors.white, size: 30.sp),
                Text(
                  'Quick actions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            color: AppColor.colorAppBar,
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Calendar(
                onPressedBack: onPressBack,
                onPressedForward: onPressForward,
                disable: false,
                // previous: Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(500),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey[300] ?? AppColor.colorWhite,
                //         spreadRadius: 1.5,
                //         blurRadius: 5,
                //         offset: const Offset(2.0, 0.0),
                //       )
                //     ],
                //   ),
                //   child: const CircleAvatar(
                //     radius: 14,
                //     backgroundColor: Colors.white,
                //     child: Icon(
                //       Icons.arrow_back_ios,
                //       size: 16,
                //       color: Colors.orange,
                //     ),
                //   ),
                // ),
                // next: Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(500),
                //     boxShadow: [
                //       BoxShadow(
                //           color: Colors.grey[300] ?? AppColor.colorWhite,
                //           spreadRadius: 1.5,
                //           blurRadius: 5,
                //           offset: const Offset(2.0, 0.0))
                //     ],
                //   ),
                //   child: const CircleAvatar(
                //     radius: 14,
                //     backgroundColor: Colors.white,
                //     child: Icon(
                //       Icons.arrow_forward_ios,
                //       size: 16,
                //       color: Colors.orange,
                //     ),
                //   ),
                // ),
                initialDate: DateTime.now(),
                weekendOpacityEnable: true,
                space: 20,
                onSelected: print,
                backgroundColor: Colors.white,
                activeColor: Colors.orange,
                textStyleDays: const TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black),
                textStyleWeekDay: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 9.sp),
                selectedStyle: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
