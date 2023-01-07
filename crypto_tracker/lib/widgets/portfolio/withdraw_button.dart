import 'package:crypto_tracker/core/res/color.dart';
import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/models/statement_type.dart';
import 'package:crypto_tracker/views/withdraw.dart';
import 'package:flutter/material.dart';

class WithdrawButton extends StatelessWidget {
  const WithdrawButton({Key? key, required this.statementType, required this.assetType}) : super(key: key);

  final StatementType statementType;
  final dynamic assetType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WithdrawScreen(statementType: statementType, assetType: assetType))),
          icon: const Icon(Icons.remove),
        )
      ],
    );
  }
}
