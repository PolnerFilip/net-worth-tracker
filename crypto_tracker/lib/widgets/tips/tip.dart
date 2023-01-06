import 'package:crypto_tracker/core/res/color.dart';
import 'package:flutter/material.dart';

class Tip extends StatelessWidget {
  const Tip({Key? key, required this.tipText}) : super(key: key);

  final String tipText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.cardColor.withOpacity(0.2)),
      child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                child: const Icon(Icons.lightbulb),
                margin: const EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text(
                  tipText,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                margin: const EdgeInsets.only(top: 40),
              )
            ],
          )),
    );
  }
}
