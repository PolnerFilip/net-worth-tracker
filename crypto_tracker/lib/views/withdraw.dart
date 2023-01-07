import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/models/statement_type.dart';
import 'package:crypto_tracker/widgets/net_worth_add/top_bar.dart';
import 'package:crypto_tracker/widgets/portfolio/withdrawal_form.dart';
import 'package:flutter/material.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({Key? key, required this.statementType, required this.assetType}) : super(key: key);

  final StatementType statementType;
  final dynamic assetType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Column(children: [
          const TopBar(),
          WithdrawForm(statementType: statementType, assetType: assetType)
        ]),
      ),
    );
  }
}
