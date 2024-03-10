import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonDatePicker extends StatefulWidget {
  final ValueChanged<String?>? onDateSelected;
  final String? selectedDate;
  const CommonDatePicker({Key? key, this.onDateSelected, this.selectedDate})
      : super(key: key);

  @override
  State<CommonDatePicker> createState() => _CommonDatePickerState();
}

class _CommonDatePickerState extends State<CommonDatePicker> {
  String _selectedDate = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate != null
          ? DateFormat("d/M/yyyy").parse(widget.selectedDate!)
          : DateTime.now(),
      firstDate: DateTime(1910),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = DateFormat("d/M/yyyy").format(pickedDate);
        widget.onDateSelected?.call(_selectedDate);
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
                widget.selectedDate ?? '',
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
