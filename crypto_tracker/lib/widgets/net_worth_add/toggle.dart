import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Toggle extends StatefulWidget {
  const Toggle({Key? key}) : super(key: key);

  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  final List<bool> _selected = <bool>[true, false];
  final List<Widget> pages = <Widget>[
    const Text('Asset'),
    const Text('Liability'),
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
              }
            });
          },
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          selectedColor: Colors.white,
          color: Colors.blue[400],
          isSelected: _selected,
          children: pages,
          constraints: BoxConstraints(minWidth: (40.w))
      ),
    );
  }
}
