import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressedFunction;

  const CommonButton(
      {super.key, required this.buttonText, this.onPressedFunction});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onPressedFunction,
        child: Container(
          decoration: ShapeDecoration(
            color: const Color(0xFF337EEE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
