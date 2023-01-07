import 'package:crypto_tracker/core/res/color.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
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
        color: AppColors.cardColor,
      ),
      child: Row(
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 20.0),
          //   child: const Icon(
          //     Icons.attach_money_outlined,
          //     color: Colors.black,
          //     size: 25,
          //
          //   ),
          // ),
          Expanded(
            child: TextFormField(
              textAlign: TextAlign.end,
              keyboardType: const TextInputType.numberWithOptions(decimal: false),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(right: 30.0),
                hintText: '\$ 0.00',
                hintStyle: TextStyle(
                  color: Colors.grey,
                )
              ),
              showCursor: false,
              inputFormatters: [
                CurrencyTextInputFormatter(symbol: '\$ '),
                LengthLimitingTextInputFormatter(15),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                return null;
              },
              onChanged: (value) =>
                  widget.callback(double.parse(value.substring(2).replaceAll(',', ''))),
            ),
          ),
        ],
      ),
    );
  }
}

