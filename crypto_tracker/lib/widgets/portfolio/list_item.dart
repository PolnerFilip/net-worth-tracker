import 'package:crypto_tracker/core/res/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    this.leading,
    required this.title,
    required this.trailing,
    required this.displayPercentage
  }) : super(key: key);

  final Widget? leading;
  final String title;
  final int trailing;
  final bool displayPercentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.bgColor,
        ),
        height: 45,
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          leading: leading,
          title: Text(title),
          trailing: Text(
            trailing.toString() + (displayPercentage ? '%' : '\$'),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          dense: true,
        ),
      ),
    );
  }
}
