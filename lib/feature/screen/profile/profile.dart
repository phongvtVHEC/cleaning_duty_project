import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/core/utils/pick_image_util.dart';
import 'package:cleaning_duty_project/core/utils/toast_util.dart';
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
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileStarted());
  }

  @override
  Widget build(BuildContext context) {
    var profileState = context.watch<ProfileBloc>().state;
    if (profileState is GetProfileFail) {
      context.pop();
      ToastUtil.showErrorMessage("Get profile fail");
    }
    if (profileState is UpdateAvatarFail) {
      ToastUtil.showErrorMessage("Update avatar fail");
      context.read<ProfileBloc>().image = context.read<ProfileBloc>().tempImage;
    }
    if (profileState is UpdateProfileSuccess) {
      ToastUtil.showSuccessMessage("Update profile success");
    }
    if (profileState is UpdateProfileFail) {
      ToastUtil.showErrorMessage("Update profile fail");
    }

    return Scaffold(
      backgroundColor: AppColor.colorWhite,
      appBar: CommonAppbarWithBackArrow(
        title: 'Profile',
        onPressedBackButton: () {
          context.read<HomeBloc>().add(HomeEvent());
          context.pop();
        },
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final profileBloc = context.read<ProfileBloc>();
          final image = profileBloc.image;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                _buildAvatarSection(context, image),
                _buildPersonalInfoSection(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAvatarSection(BuildContext context, String image) {
    final profileBloc = context.read<ProfileBloc>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            try {
              String newImage = await PickImageUtil.pickImage();
              profileBloc.updateAvatar(newImage);
            } catch (e) {
              return;
            }
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
                  border: Border.all(width: 1, color: AppColor.color10275A),
                  color: image.isEmpty ? Colors.grey : null,
                  image: image.isNotEmpty && image.startsWith('http')
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
                              'Local Image',
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
    );
  }

  Widget _buildPersonalInfoSection(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Name',
            style: TextStyle(fontSize: 14, color: AppColor.color10275A),
          ),
          CommonTextField(
            maxLines: 1,
            inputController: profileBloc.nameController,
          ),
          SizedBox(height: 20.h),
          const Text(
            'Email',
            style: TextStyle(fontSize: 14, color: AppColor.color10275A),
          ),
          CommonTextField(
            maxLines: 1,
            inputController: profileBloc.emailController,
          ),
          SizedBox(height: 20.h),
          const Text(
            'Date of Birth',
            style: TextStyle(fontSize: 14, color: AppColor.color10275A),
          ),
          CommonDatePicker(
            selectedDate: context.read<ProfileBloc>().dateOfBirth,
            onDateSelected: (value) {
              setState(() {
                context.read<ProfileBloc>().dateOfBirth = value ?? '';
              });
            },
          ),
          SizedBox(height: 20.h),
          const Text(
            'Phone number',
            style: TextStyle(fontSize: 14, color: AppColor.color10275A),
          ),
          CommonTextField(
            maxLines: 1,
            inputController: profileBloc.phoneController,
          ),
          SizedBox(height: 30.h),
          CommonButton(
            isDisable: profileBloc.isDisable,
            buttonText: 'Save changes',
            onPressedFunction: () {
              profileBloc.updateProfile();
            },
          ),
        ],
      ),
    );
  }
}
