import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/res/color.dart';
import '../../views/net_worth_add.dart';

class NetWorthTile extends StatelessWidget {
  const NetWorthTile({Key? key}) : super(key: key);

  void navigate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NetWorthAdd())
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30.h,
        width: 100.w,
        child: Stack(children: [
          Container(
            height: 30.h,
            decoration: BoxDecoration(
                gradient: AppColors.getDarkLinearGradient(Colors.indigo),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(40),
                )),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Current Net Worth",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "\$ 231.223",
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.2,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          onPressed: () => navigate(context),
                          icon: const Icon(
                            Icons.add_circle_outline_outlined,
                            size: 26,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.white.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          size: 14,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "\$ 5.10",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ]));
  }
}
