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
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final profileBloc = context.read<ProfileBloc>();
          final image = profileBloc.image;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        String newImage;
                        try {
                          newImage = await PickImageUlti.pickImage();
                        } catch (e) {
                          return;
                        }

                        setState(() {
                          profileBloc.image = newImage;
                        });
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 130.w,
                            height: 130.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 1, color: AppColor.color10275A),
                              color: image.isEmpty ? Colors.grey : null,
                              image:
                                  image.isNotEmpty && image.startsWith('http')
                                      ? DecorationImage(
                                          image: NetworkImage(image),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                            ),
                            child: image.isEmpty
                                ? const Icon(Icons.person, color: Colors.white)
                                : image.isEmpty || image.startsWith('http')
                                    ? null
                                    : const Center(
                                        child: Text(
                                          'Local Image', // You can display a text for local image
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: const Icon(
                              Icons.camera_alt,
                              color: AppColor.color10275A,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 14, color: AppColor.color10275A),
                      ),
                      CommonTextField(
                        maxLines: 1,
                        inputController: profileBloc.nameController,
                      ),
                      SizedBox(height: 20.h),
                      const Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 14, color: AppColor.color10275A),
                      ),
                      CommonTextField(
                        maxLines: 1,
                        inputController: profileBloc.emailController,
                      ),
                      SizedBox(height: 20.h),
                      const Text(
                        'Date of Birth',
                        style: TextStyle(
                            fontSize: 14, color: AppColor.color10275A),
                      ),
                      CommonDatePicker(
                        selectedDate: context.read<ProfileBloc>().dateOfBirth,
                        onDateSelected: (value) {
                          setState(() {
                            context.read<ProfileBloc>().dateOfBirth =
                                value ?? '';
                          });
                        },
                      ),
                      SizedBox(height: 20.h),
                      const Text(
                        'Phone number',
                        style: TextStyle(
                            fontSize: 14, color: AppColor.color10275A),
                      ),
                      CommonTextField(
                        maxLines: 1,
                        inputController: profileBloc.phoneController,
                      ),
                      SizedBox(height: 30.h),
                      CommonButton(
                        buttonText: 'Save changes',
                        onPressedFunction: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
