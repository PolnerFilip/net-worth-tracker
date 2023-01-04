
import 'package:crypto_tracker/models/asset_type.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AssetTypeDropdown extends StatefulWidget {
  const AssetTypeDropdown({Key? key, required this.callback}) : super(key: key);

  final Function callback;

  @override
  State<AssetTypeDropdown> createState() => _AssetTypeDropdownState();
}

class _AssetTypeDropdownState extends State<AssetTypeDropdown> {
  final List<String> items = [
    AssetType.CRYPTOCURRENCY.name!,
    AssetType.CASH.name!,
    AssetType.REAL_ESTATE.name!,
    AssetType.STOCK.name!
  ];
  String? selectedValue = AssetType.CRYPTOCURRENCY.name!;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      width: 80.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.2),
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
                fontSize: 14,
                fontWeight: FontWeight.bold,
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
            switch (value) {
              case 'Cryptocurrency': widget.callback(AssetType.CRYPTOCURRENCY); break;
              case 'Cash': widget.callback(AssetType.CASH); break;
              case 'Real Estate': widget.callback(AssetType.REAL_ESTATE); break;
              case 'Stock': widget.callback(AssetType.STOCK); break;
              default: return;
            }
          },
          icon: const Icon(
            Icons.keyboard_arrow_down_sharp,
          ),
          iconSize: 25,
          buttonHeight: 50,
          buttonWidth: 160,
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonElevation: 2,
          itemHeight: 40,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownWidth: 80.w,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[700],
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
