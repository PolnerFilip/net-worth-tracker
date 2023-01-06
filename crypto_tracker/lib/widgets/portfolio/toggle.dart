import 'package:crypto_tracker/core/res/color.dart';
import 'package:flutter/material.dart';

class Toggle extends StatefulWidget {
  const Toggle({
    Key? key,
    required this.callback
  }) : super(key: key);

  final Function callback;

  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  final List<bool> _selected = <bool>[true, false];
  final List<Widget> icons = <Widget>[
    const Icon(Icons.percent_sharp, size: 20),
    const Icon(Icons.attach_money_sharp, size: 20)
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ToggleButtons(
        direction: Axis.horizontal,
        onPressed: (int index) {
          setState(() {
            for (int i = 0; i < _selected.length; i++) {
              _selected[i] = i == index;
              widget.callback(index);
            }
          });
        },
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        borderColor: AppColors.bgColor,
        fillColor: AppColors.cardColor.withOpacity(0.2),
        color: AppColors.cardColor.withOpacity(0.5),
        selectedBorderColor: AppColors.bgColor,
        selectedColor: Colors.white,
        isSelected: _selected,
        children: icons,
      ),
    );
  }
}
