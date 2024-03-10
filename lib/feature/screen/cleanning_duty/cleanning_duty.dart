import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:cleaning_duty_project/feature/widget/Appbar/common_appbar_with_back_arrow.dart';
import 'package:cleaning_duty_project/feature/widget/Multiselect/common_multi_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CleanningDuty extends StatefulWidget {
  const CleanningDuty({super.key});

  @override
  State<CleanningDuty> createState() => _CleanningDutyState();
}

const List myList = [
  {'id': 'dog', 'label': 'Dog'},
  {'id': 'cat', 'label': 'Cat'},
  {'id': 'mouse', 'label': 'Mouse'},
  {'id': 'rabbit', 'label': 'Rabbit'},
];

class _CleanningDutyState extends State<CleanningDuty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWithBackArrow(
        title: 'Cleanning Duty',
        onPressedBackButton: () {
          Navigator.pop(context);
        },
      ),
      body: MultiSelectDropdown(
        textStyle: TextStyle(
            fontSize: 14.sp,
            color: AppColor.color10275A,
            fontWeight: FontWeight.w400),
        boxDecoration: BoxDecoration(
          border: Border.all(
              color: AppColor.colorTextFieldBorder), // Example border style
          borderRadius: BorderRadius.circular(10), // Example border radius
        ),
        includeSearch: true,
        includeSelectAll: true,
        list: myList,
        initiallySelected: const [],
        onChange: (newList) {},
      ),
    );
  }
}
