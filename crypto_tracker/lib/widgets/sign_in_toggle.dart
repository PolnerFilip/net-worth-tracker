import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Toggle extends StatefulWidget {
  const Toggle({Key? key, required this.callback}) : super(key: key);

  final Function callback;
  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  final List<bool> _selected = <bool>[true, false];
  final List<Widget> pages = <Widget>[
    const Text('Sign In'),
    const Text('Sign Up'),
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
            widget.callback(index);
          },
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          selectedColor: Colors.white,
          color: Colors.grey,
          isSelected: _selected,
          children: pages,
          constraints: BoxConstraints(minWidth: (40.w), minHeight:  (60.h))
      ),
    );
  }
}