import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextField extends StatelessWidget {
  final String label;
  final TextEditingController? inputController;
  const CommonTextField({
    Key? key,
    required this.label,
    this.inputController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 335.w,
          height: 59.h,
          child: Stack(
            children: [
              TextField(
                controller: inputController,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(
                    color: const Color(0xFF337EEE),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1.w, color: const Color(0xFFEBF2FD)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2.w, color: const Color(0xFFEBF2FD)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
