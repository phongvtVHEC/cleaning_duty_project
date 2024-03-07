import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonDatePicker extends StatefulWidget {
  const CommonDatePicker({Key? key}) : super(key: key);

  @override
  State<CommonDatePicker> createState() => _CommonDatePickerState();
}

class _CommonDatePickerState extends State<CommonDatePicker> {
  String _selectedDate = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year + 1),
      firstDate: DateTime(1910),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = DateFormat.yMMMMd("en_US").format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          _selectDate(context);
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.colorWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: AppColor.colorTextFieldBorder,
            ),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _selectedDate,
                textAlign: TextAlign.start,
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                tooltip: 'Tap to open date picker',
                onPressed: () {
                  _selectDate(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
