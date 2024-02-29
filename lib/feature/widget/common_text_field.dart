import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String label;
  final TextEditingController inputController;
  const CommonTextField({
    Key? key,
    required this.label,
    required this.inputController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 335,
          height: 59,
          child: Stack(
            children: [
              TextField(
                controller: inputController,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: const TextStyle(
                    color: Color(0xFF337EEE),
                    fontSize: 14,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xFFEBF2FD)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2, color: Color(0xFFEBF2FD)),
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
