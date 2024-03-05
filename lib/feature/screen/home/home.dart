import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/feature/blocs/authenticate/logout/bloc/logout_bloc.dart';
import 'package:cleaning_duty_project/feature/blocs/home/bloc/bottom_sheet_bloc.dart';
import 'package:cleaning_duty_project/feature/widget/Calendar/calendar_page.dart';
import 'package:cleaning_duty_project/feature/widget/common_appbar_with_date_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final GlobalKey<CalendarState> _calendarKey = GlobalKey();
  bool isDisable = false;
  void Function()? onPressBack;
  void Function()? onPressForward;
  IconData? iconBottomSheet;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorWhite,
      key: _key,
      drawer: Drawer(
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
                  BlocProvider.of<LogoutBloc>(context).add(LogoutEvent());
                },
              ),
            ],
          ),
        ),
      ),
      appBar: CommonAppbarWithDateBar(
        globalKey: _key,
        year: '2021',
        month: 'June',
        onPressBack: () {
          _calendarKey.currentState!.onPressBackFunction();
        },
        onPressForward: () {
          _calendarKey.currentState!.onPressForwardFunction();
        },
      ),
      bottomSheet: BlocBuilder<BottomSheetBloc, BottomSheetState>(
        builder: (context, state) {
          if (state is BottomSheetInitial) {
            iconBottomSheet = Icons.expand_less_sharp;
          }
          if (state is BottomSheetOpened) {
            iconBottomSheet = Icons.expand_more_sharp;
          } else {
            iconBottomSheet = Icons.expand_less_sharp;
          }
          return SolidBottomSheet(
            onShow: () {},
            onHide: () {},
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
                  Icon(iconBottomSheet ?? Icons.expand_less_rounded,
                      color: Colors.white, size: 30.sp),
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: Calendar(
              key: _calendarKey,
              onPressedBack: () {
                onPressBack;
              },
              onPressedForward: onPressForward,
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
