import 'dart:io';
import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/utils/pick_image_ulti.dart';
import 'package:cleaning_duty_project/feature/blocs/home/home/home_bloc.dart';
import 'package:cleaning_duty_project/feature/blocs/profile/bloc/profile_bloc.dart';
import 'package:cleaning_duty_project/feature/widget/Appbar/common_appbar_with_back_arrow.dart';
import 'package:cleaning_duty_project/feature/widget/Button/common_button.dart';
import 'package:cleaning_duty_project/feature/widget/DatePicker/common_date_picker.dart';
import 'package:cleaning_duty_project/feature/widget/textfield/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileEvent());
  }

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
                GestureDetector(
                  onTap: () async {
                    String newImage = await PickImageUlti.pickImage();
                    setState(() {
                      context.read<ProfileBloc>().image = newImage;
                    });
                  },
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return Container(
                          alignment: Alignment.center,
                          width: 130.w,
                          height: 130.h,
                          decoration: context
                                  .read<ProfileBloc>()
                                  .image
                                  .startsWith('http')
                              ? ShapeDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        context.read<ProfileBloc>().image),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: const OvalBorder(
                                    side: BorderSide(
                                        width: 1, color: AppColor.color10275A),
                                  ),
                                )
                              : ShapeDecoration(
                                  image: DecorationImage(
                                    image: FileImage(File(
                                        context.read<ProfileBloc>().image)),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: const OvalBorder(
                                    side: BorderSide(
                                        width: 1, color: AppColor.color10275A),
                                  ),
                                ),
                          child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: const Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: AppColor.color10275A,
                                ),
                              ),
                            ),
                          ));
                    },
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
                  const CommonDatePicker(),
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
