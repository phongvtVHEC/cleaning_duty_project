import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/feature/blocs/home/home/home_bloc.dart';
import 'package:cleaning_duty_project/feature/widget/Appbar/common_appbar_with_back_arrow.dart';
import 'package:cleaning_duty_project/feature/widget/Button/common_button.dart';
import 'package:cleaning_duty_project/feature/widget/DatePicker/common_date_picker.dart';
import 'package:cleaning_duty_project/feature/widget/textfield/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorWhite,
      appBar: CommonAppbarWithBackArrow(
          title: 'Profile',
          onPressedBackButton: () {
            context.read<HomeBloc>().add(HomeEvent());

            context.pop();
          }),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 130.w,
                  height: 130.h,
                  decoration: const ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg"),
                      fit: BoxFit.cover,
                    ),
                    shape: OvalBorder(
                      side: BorderSide(width: 1, color: AppColor.colorGrey),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Name',
                      style:
                          TextStyle(fontSize: 14, color: AppColor.color10275A)),
                  const CommonTextField(label: "", maxLines: 1),
                  SizedBox(
                    height: 20.h,
                  ),
                  const Text('Email',
                      style:
                          TextStyle(fontSize: 14, color: AppColor.color10275A)),
                  const CommonTextField(label: "", maxLines: 1),
                  SizedBox(
                    height: 20.h,
                  ),
                  const Text('Date of Birth',
                      style:
                          TextStyle(fontSize: 14, color: AppColor.color10275A)),
                  CommonDatePicker(),
                  SizedBox(
                    height: 20.h,
                  ),
                  const Text('Phone number',
                      style:
                          TextStyle(fontSize: 14, color: AppColor.color10275A)),
                  const CommonTextField(label: "", maxLines: 1),
                  SizedBox(
                    height: 30.h,
                  ),
                  CommonButton(
                      buttonText: 'Save changes', onPressedFunction: () {})
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
