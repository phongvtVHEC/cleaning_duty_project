import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/core/utils/toast_util.dart';
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
import 'package:outline_material_icons/outline_material_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeStarted(false));
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: CommonAppbarWithDateBar(
        globalKey: context.read<HomeBloc>().key,
        onPressBack: () {
          context.read<HomeBloc>().handleDateBarPreviousUpdated(context);
          homeBloc.calendarKey.currentState!.onPressBackFunction();
        },
        onPressForward: () {
          context.read<HomeBloc>().handleDateBarForwardUpdated(context);
          homeBloc.calendarKey.currentState!.onPressForwardFunction();
        },
      ),
      bottomSheet: _buidlBottomSheet(context),
      body: CommonCalendar(
        funtionOnTapDate: (p0) {},
      ),
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
              if (state is DateBarUpdated) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconButton(
                  OMIcons.person,
                  AppColor.colorE06D06,
                  'Profile',
                  () {
                    context.read<HomeBloc>().resetState(context);
                    context.push(ScreenRoute.profileScreen);
                  },
                ),
                _buildIconButton(
                  OMIcons.personAdd,
                  AppColor.color219653,
                  'Add Duty',
                  () {
                    context.read<HomeBloc>().resetState(context);
                    context.push(ScreenRoute.cleanningDutyScreen);
                  },
                ),
                _buildIconButton(
                  Icons.logout_outlined,
                  AppColor.colorEB5757,
                  'Logout',
                  () {
                    context.read<LogoutBloc>().handleLogout(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildIconButton(
  IconData icon,
  Color color,
  String text,
  VoidCallback onPressed,
) {
  return Column(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: ShapeDecoration(
              color: AppColor.colorWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              size: 40.sp,
              color: color,
              weight: 100,
            ),
          ),
        ],
      ),
      Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
          fontFamily: Constants.app_font_Lato,
        ),
      ),
    ],
  );
}
