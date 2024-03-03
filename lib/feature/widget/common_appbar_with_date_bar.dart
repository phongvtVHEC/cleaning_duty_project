import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/feature/widget/common_date_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CommonAppbarWithDateBar extends StatelessWidget
    implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> globalKey;
  final String year;
  final String month;
  final Function()? onPressBack;
  final Function()? onPressForward;

  const CommonAppbarWithDateBar(
      {super.key,
      required this.globalKey,
      required this.year,
      required this.month,
      this.onPressBack,
      this.onPressForward});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0.h,
      child: Stack(
        children: <Widget>[
          Container(
            color: AppColor.colorAppBar,
            width: MediaQuery.of(context).size.width,
            height: 100.0.h,
            child: Stack(
              children: [
                const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.dehaze,
                      //     color: AppColor.colorWhite,
                      //     size: 20.sp,
                      //   ),
                      //   onPressed: () {
                      //     globalKey.currentState!.openDrawer();
                      //   },
                      // ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    DateFormat('EEEE, dd MMM').format(DateTime.now()),
                    style: TextStyle(
                      color: AppColor.colorWhite,
                      fontFamily: Constants.app_font_Lato,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          CommonDateBar(
            month: month,
            year: year,
            onPressedBack: onPressBack,
            onPressedForward: onPressForward,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(160.sp);
}
