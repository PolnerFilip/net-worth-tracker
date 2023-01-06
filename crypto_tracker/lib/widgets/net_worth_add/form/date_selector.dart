import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../core/res/color.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({Key? key, required this.callback}) : super(key: key);

  final Function callback;

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDate;
  String? _formattedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _formattedDate = DateFormat('d. MMM yyyy').format(_selectedDate!);
        widget.callback(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        height: 8.h,
        width: 80.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.cardColor.withOpacity(0.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                _formattedDate ?? 'Select date',
                style: const TextStyle(fontSize: 15),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.date_range_sharp),
            )
          ],
        ),
      ),
    );
  }
}
