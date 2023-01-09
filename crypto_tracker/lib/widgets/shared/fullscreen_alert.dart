import 'package:flutter/material.dart';

import '../../core/res/color.dart';

class FullscreenAlert extends StatelessWidget {
  const FullscreenAlert({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor.withOpacity(0.90),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
            child: Text(
              title,
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cardColor,
                shape: CircleBorder(),
                padding: EdgeInsets.all(12.5),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.clear))
        ],
      ),
    );
  }
}
