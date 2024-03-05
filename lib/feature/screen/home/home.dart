import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/core/utils/toast_ulti.dart';
import 'package:cleaning_duty_project/feature/blocs/authenticate/logout/bloc/logout_bloc.dart';
import 'package:cleaning_duty_project/feature/blocs/home/bloc/home_bloc.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeBloc>().state;

    var bottomSheetIcon = (switch (homeState) {
      BottomSheetInitial() => Icons.expand_less_sharp,
      BottomSheetOpened() => Icons.expand_more_sharp,
      BottomSheetClosed() => Icons.expand_less_sharp,
      _ => Icons.expand_less_sharp,
    });

    bottomSheetIcon = BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is BottomSheetOpened) {
          context.read<HomeBloc>().iconBottomSheet = Icons.expand_more_sharp;
        }
        if (state is BottomSheetClosed) {
          context.read<HomeBloc>().iconBottomSheet = Icons.expand_less_sharp;
        }
      },
      child: context.read<HomeBloc>().iconBottomSheet,
    );
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
      bottomSheet: SolidBottomSheet(
        toggleVisibilityOnTap: true,
        canUserSwipe: true,
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
              Icon(bottomSheetIcon, color: Colors.white, size: 30.sp),
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
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Calendar(
              key: context.read<HomeBloc>().calendarKey,
              disable: false,
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
    );
  }
}
