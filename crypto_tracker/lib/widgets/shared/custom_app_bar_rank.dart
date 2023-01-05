import 'package:crypto_tracker/utils/show_amount_notifier.dart';
import 'package:crypto_tracker/views/home/settings.dart';
import 'package:flutter/material.dart';

import '../../core/res/color.dart';

class CustomAppBar extends StatefulWidget {
  CustomAppBar({Key? key, required this.rank}) : super(key: key);

  final String rank;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isHidden = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottomOpacity: 0.0,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leadingWidth: 200,
      flexibleSpace: Container(color: AppColors.cardColor.withOpacity(0.6),),
      leading: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 15),
            child: Image.asset(
              'assets/Rank.png',
              width: 25,
              color: Colors.white,
            ),
          ),
          Text(
            'Rank ${widget.rank}',
            style: const TextStyle(color: Colors.white, fontSize: 15),
          )
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                isHidden = !isHidden;
              });
              ShowNotifier().show = !isHidden;
              print('ISHIDDEN' + isHidden.toString());
              print('SHOW: ' + ShowNotifier().show.toString());
            },
            icon: (isHidden) ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(onPressed: () {
            Navigator.of(context).push( MaterialPageRoute(builder: (context) => Settings()),);
          }, icon: const Icon(Icons.settings)),
        )
      ],
    );
  }
}
