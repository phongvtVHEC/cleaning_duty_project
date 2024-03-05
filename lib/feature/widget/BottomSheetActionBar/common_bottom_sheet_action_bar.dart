import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/feature/blocs/home/bottom_sheet/bottom_sheet_bloc.dart';
import 'package:cleaning_duty_project/feature/widget/BottomSheetActionBar/package/smoothness.dart';
import 'package:cleaning_duty_project/feature/widget/BottomSheetActionBar/package/solidBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonBottomSheetActionBar extends StatelessWidget {
  const CommonBottomSheetActionBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SolidBottomSheet(
      controller: context.read<BottomSheetBloc>().solidController,
      onShow: () {
        context.read<BottomSheetBloc>().handleBottomSheetOpened(context);
      },
      onHide: () {
        context.read<BottomSheetBloc>().handleBottomSheetClosed(context);
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
            BlocBuilder<BottomSheetBloc, BottomSheetState>(
              builder: (context, state) {
                Icon? bottomSheetIcon;
                if (state is BottomSheetOpened) {
                  bottomSheetIcon = Icon(Icons.keyboard_arrow_down,
                      color: Colors.white, size: 30.sp);
                } else if (state is BottomSheetClosed) {
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
        color: AppColor.colorAppBar,
      ),
    );
  }
}
