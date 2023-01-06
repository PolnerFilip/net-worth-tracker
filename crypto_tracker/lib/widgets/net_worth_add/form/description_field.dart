import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/res/color.dart';

class DescriptionField extends StatefulWidget {
  const DescriptionField({Key? key, required this.callback}) : super(key: key);

  final Function callback;

  @override
  State<DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.cardColor.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          style: TextStyle(fontSize: 15),
          keyboardType: TextInputType.multiline,
          maxLines: 10,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(right: 30.0),
              hintText: 'Description',

          ),
          onChanged: (value) => widget.callback(value),
        ),
      ),
    );
  }
}
