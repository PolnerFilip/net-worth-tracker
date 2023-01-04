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
        padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
          ),
          onPressed: () => Navigator.pop(context)  ,
        )
      ),
      actions: [
        const Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(Icons.search),
        ),
        Padding(
          padding:
          const EdgeInsets.only(right: 15.0, top: 10, bottom: 10),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
