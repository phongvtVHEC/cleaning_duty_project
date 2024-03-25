import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/feature/blocs/cleanning_duty/bloc/cleanning_duty_bloc.dart';
import 'package:cleaning_duty_project/feature/widget/Appbar/common_appbar_with_back_arrow.dart';
import 'package:cleaning_duty_project/feature/widget/Multiselect/common_multi_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CleanningDuty extends StatefulWidget {
  const CleanningDuty({super.key});

  @override
  State<CleanningDuty> createState() => _CleanningDutyState();
}

class _CleanningDutyState extends State<CleanningDuty> {
  @override
  void initState() {
    super.initState();
    context.read<CleanningDutyBloc>().add(CleanningDutyStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWithBackArrow(
        title: 'Cleanning Duty',
        onPressedBackButton: () {
          Navigator.pop(context);
        },
      ),
      body: BlocBuilder<CleanningDutyBloc, CleanningDutyState>(
        builder: (context, state) {
          if (state is CleanningDutySuccess) {
            return MultiSelectDropdown(
              textStyle: TextStyle(
                fontSize: 14.sp,
                color: AppColor.color10275A,
                fontWeight: FontWeight.w400,
              ),
              boxDecoration: BoxDecoration(
                border: Border.all(color: AppColor.colorTextFieldBorder),
                borderRadius: BorderRadius.circular(10),
              ),
              includeSearch: true,
              includeSelectAll: true,
              list: context.read<CleanningDutyBloc>().mappedList ?? [],
              initiallySelected: const [],
              onChange: (newList) {},
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
