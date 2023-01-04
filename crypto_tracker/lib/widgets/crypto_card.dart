import 'package:crypto_tracker/core/res/color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.cardColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.currency_exchange,
                    color: Colors.blue[100],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Earn Ethereum",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              // const Spacer(),
              // Text(
              //   "Investment Solution",
              //   style: TextStyle(
              //     fontWeight: FontWeight.w300,
              //     fontSize: 14,
              //     color: Colors.white.withOpacity(0.8),
              //   ),
              // ),
            ],
          ),
        )
      ]),
    );
  }
}
