import 'package:crypto_tracker/services/net_worth_observer.dart';
import 'package:crypto_tracker/utils/show_amount_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../core/res/color.dart';
import '../../views/net_worth_add.dart';

class NetWorthTile extends StatefulWidget {
  const NetWorthTile({Key? key}) : super(key: key);

  @override
  State<NetWorthTile> createState() => _NetWorthTileState();
}

class _NetWorthTileState extends State<NetWorthTile> {
  ShowNotifier showNotifier = ShowNotifier();
  String hiddenValue = '';

  @override
  void initState() {
    hiddenValue = '\u2731' * 4;
    NetWorthObserver.instance.addListener(() {
      setState(() {});
    });

    showNotifier.addListener(() => mounted ? setState(() {}) : null);
    super.initState();
  }

  void navigate(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const NetWorthAdd()));
  }

  @override
  void dispose() {
    showNotifier.removeListener(() => setState(() {}));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 20.h,
        width: 100.w,
        child: Stack(children: [
          Container(
            height: 30.h,
            // decoration: BoxDecoration(
            //     color: AppColors.cardColor.withOpacity(0.6),
            //     borderRadius: const BorderRadius.vertical(
            //       bottom: Radius.circular(10),
            //     )),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppColors.bgColor, AppColors.cardColor.withOpacity(0.6)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.0, 1],
                  tileMode: TileMode.clamp),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Current Net Worth:",
                      style: TextStyle(color: Colors.white, letterSpacing: 0.7, fontSize: 15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (ShowNotifier().show)
                              ? NumberFormat.simpleCurrency(decimalDigits: 0).format(NetWorthObserver.instance.netWorth)
                              : hiddenValue,
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: ShowNotifier().show ? 45 : 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                            onPressed: () => navigate(context),
                            icon: const Icon(
                              Icons.add,
                              size: 40,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
