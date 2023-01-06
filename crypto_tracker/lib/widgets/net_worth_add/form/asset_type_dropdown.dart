
import 'package:crypto_tracker/models/asset_type.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/res/color.dart';

class AssetTypeDropdown extends StatefulWidget {
  const AssetTypeDropdown({Key? key, required this.callback}) : super(key: key);

  final Function callback;

  @override
  State<AssetTypeDropdown> createState() => _AssetTypeDropdownState();
}

class _AssetTypeDropdownState extends State<AssetTypeDropdown> {
  final List<String> items = [
    EnumToString.convertToString(AssetType.CRYPTOCURRENCY),
    EnumToString.convertToString(AssetType.CASH),
    EnumToString.convertToString(AssetType.REAL_ESTATE),
    EnumToString.convertToString(AssetType.STOCK)
  ];
  String? selectedValue = EnumToString.convertToString(AssetType.CRYPTOCURRENCY);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      width: 80.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.cardColor.withOpacity(0.2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          items: items
              .map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
            print(selectedValue);
            widget.callback(EnumToString.fromString(AssetType.values, selectedValue!));
          },
          icon: const Icon(
            Icons.keyboard_arrow_down_sharp,
          ),
          iconSize: 25,
          buttonHeight: 50,
          buttonWidth: 160,
          buttonPadding: const EdgeInsets.only(left: 20, right: 14),
          buttonElevation: 2,
          itemHeight: 40,
          itemPadding: const EdgeInsets.only(left: 20, right: 14),
          dropdownMaxHeight: 200,
          dropdownWidth: 80.w,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
          ),
          dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
        ),
      ),
    );
  }
}
