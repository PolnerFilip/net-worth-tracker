import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 0.0, top: 10, bottom: 10),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
          ),
          onPressed: () => Navigator.pop(context)  ,
        )
      ),
    );
  }
}
