import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/res/color.dart';

class CryptoAmountInput extends StatefulWidget {
  const CryptoAmountInput({Key? key, required this.callback, required this.enabled}) : super(key: key);

  final Function callback;
  final bool enabled;

  @override
  State<CryptoAmountInput> createState() => _CryptoAmountInputState();
}

class _CryptoAmountInputState extends State<CryptoAmountInput> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      width: 47.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.enabled ? AppColors.cardColor : Colors.grey.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              enabled: widget.enabled,
              textAlign: TextAlign.end,
              keyboardType: const TextInputType.numberWithOptions(decimal: false),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(right: 30.0),
                  hintText: widget.enabled ? '0.000' : '',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  )
              ),
              showCursor: false,
              inputFormatters: [
                CurrencyTextInputFormatter(symbol: '', decimalDigits: 3),
                LengthLimitingTextInputFormatter(7),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                return null;
              },
              onChanged: (value) {
                widget.callback((value == '') ? 0.0 : double.parse(value.replaceAll(',', '')));
              }
            ),
          ),
        ],
      ),
    );
  }
}
