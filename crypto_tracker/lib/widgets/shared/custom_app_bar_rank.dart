import 'package:crypto_tracker/utils/show_amount_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/res/color.dart';
import '../../services/net_worth_observer.dart';
import '../../views/home/authentification_screen.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isHidden = false;

  @override
  void initState() {
    NetWorthObserver.instance.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottomOpacity: 0.0,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leadingWidth: 500,
      flexibleSpace: Container(
        color: AppColors.cardColor.withOpacity(0.6),
      ),
      leading: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 12.5, bottom: 2),
            child: Image.asset(
              'assets/Rank.png',
              width: 24,
              color: Colors.yellow[600],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(
                'Rank:',
                style: TextStyle(color: Colors.grey[400], fontSize: 8),
              ),
              Text(
                NetWorthObserver.instance.rank,
                style: TextStyle(color: Colors.grey[200], fontSize: 18),
              ),
            ],
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
            },
            icon: (isHidden) ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)),
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: IconButton(
              onPressed: () async{
                await FirebaseAuth.instance.signOut();
                Navigator.of(context, rootNavigator: true)
                    .pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const SignInScreen();
                    },
                  ),
                      (_) => false,
                );
              },
              icon: const Icon(Icons.logout)),
        )
      ],
    );
  }
}
