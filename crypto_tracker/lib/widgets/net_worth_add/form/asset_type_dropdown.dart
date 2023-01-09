
import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/models/liability_type.dart';
import 'package:crypto_tracker/models/statement_type.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/res/color.dart';

class AssetTypeDropdown extends StatefulWidget {
  const AssetTypeDropdown({Key? key, required this.callback, required this.statementType}) : super(key: key);

  final Function callback;
  final StatementType statementType;

  @override
  State<AssetTypeDropdown> createState() => _AssetTypeDropdownState();
}

class _AssetTypeDropdownState extends State<AssetTypeDropdown> {
  List<String> _items = AssetType.values.map((value) => value.name!).toList();
  String? _selectedValue = AssetType.CRYPTOCURRENCY.name;

  @override
  Widget build(BuildContext context) {
    if(widget.statementType == StatementType.LIABILITY) {
      _items = LiabilityType.values.map((value) => value.name!).toList();
      if(getLiabilityTypeFromName(_selectedValue!) == null) {
        _selectedValue = LiabilityType.STUDENT_LOAN.name;
      }

    } else {
      _items = AssetType.values.map((value) => value.name!).toList();
      if(getAssetFromName(_selectedValue!) == null) {
        _selectedValue = AssetType.CRYPTOCURRENCY.name;
      }

    }

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
          items: _items
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
          value: _selectedValue ?? LiabilityType.STUDENT_LOAN,
          onChanged: (value) {
            setState(() {
              _selectedValue = value as String;
            });
            widget.callback(widget.statementType == StatementType.ASSET ? getAssetFromName(_selectedValue!) : getLiabilityTypeFromName(_selectedValue!));
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
