import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/thousands_input_formatter.dart';

class AmountInput extends StatefulWidget {
  const AmountInput({Key? key, required this.callback}) : super(key: key);

  final Function callback;

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      width: 80.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: const Icon(
              Icons.attach_money_outlined,
              color: Colors.black,
              size: 25,

            ),
          ),
          Expanded(
            child: TextFormField(
              textAlign: TextAlign.end,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(right: 30.0)
              ),
              showCursor: false,
              inputFormatters: [
                ThousandsSeparatorInputFormatter(),
                LengthLimitingTextInputFormatter(10)
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (value) => widget.callback(value),
            ),
          ),
        ],
      ),
    );
  }
}

