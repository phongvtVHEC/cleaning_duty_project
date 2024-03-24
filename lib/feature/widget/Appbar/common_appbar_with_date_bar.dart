import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/feature/blocs/home/home/home_bloc.dart';
import 'package:cleaning_duty_project/feature/widget/DateBar/common_date_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CommonAppbarWithDateBar extends StatelessWidget
    implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> globalKey;
  final Function()? onPressBack;
  final Function()? onPressForward;

  const CommonAppbarWithDateBar({
    super.key,
    required this.globalKey,
    this.onPressBack,
    this.onPressForward,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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
                    Center(
                      child: Text(
                        DateFormat('EEEE, dd MMM').format(DateTime.now()),
                        style: TextStyle(
                          color: AppColor.colorWhite,
                          fontFamily: Constants.app_font_Lato,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return CommonDateBar(
                    month: context
                        .read<HomeBloc>()
                        .convertMonthFromNumberToString(
                            context.read<HomeBloc>().currentMonth ?? ''),
                    year: context.read<HomeBloc>().currentYear ?? '',
                    onPressedBack: onPressBack,
                    onPressedForward: onPressForward,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(160.sp);
}
