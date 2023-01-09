import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/models/liability_type.dart';
import 'package:crypto_tracker/models/statement_type.dart';
import 'package:crypto_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crypto_tracker/core/res/icons.dart';

import '../../core/res/color.dart';
import '../../models/transaction_type.dart';
import '../../utils/show_amount_notifier.dart';

class HistoryListItem extends StatefulWidget {
  const HistoryListItem({Key? key, required this.entry, required this.show}) : super(key: key);

  final TransactionModel entry;
  final bool show;

  @override
  State<HistoryListItem> createState() => _HistoryListItemState();
}

class _HistoryListItemState extends State<HistoryListItem> {
  ShowNotifier showNotifier = ShowNotifier();
  late AssetType assetType;
  late LiabilityType liabilityType;

  @override
  void initState() {
    showNotifier.addListener(() => mounted ? setState(() {}) : null);
    if (widget.entry.statementType == StatementType.ASSET) {
      assetType = widget.entry.assetType;
    } else {
      liabilityType = widget.entry.assetType;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HistoryListItem oldWidget) {
    if (widget.entry.statementType == StatementType.ASSET) {
      assetType = widget.entry.assetType;
    } else {
      liabilityType = widget.entry.assetType;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SizedBox(
        height: 70,

        child: DecoratedBox(
          decoration: BoxDecoration(
              color: (widget.entry.statementType == StatementType.ASSET) ? AppColors.cardColor.withOpacity(0.2) : Colors.red.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: const EdgeInsets.only(right: 15.0),
                        child: widget.entry.statementType == StatementType.ASSET ? Icon(CustomIcons.getAssetIcon(assetType.name!)) : Icon(
                            CustomIcons.getLiabilityIcon(liabilityType.name!))),
                    Text(
                      widget.entry.statementType == StatementType.ASSET ? assetType.name ?? '' : liabilityType.name ?? '',
                      style: const TextStyle(fontWeight: FontWeight.normal, letterSpacing: 0.7, fontSize: 15.5),
                    )
                  ],
                ),
              ),
              Text(
                (widget.entry.transactionType == TransactionType.DEPOSIT && widget.entry.statementType == StatementType.ASSET ||
                    widget.entry.transactionType == TransactionType.WITHDRAWAL && widget.entry.statementType == StatementType.LIABILITY)
                    ? '+ ${NumberFormat.simpleCurrency().format(widget.entry.amount)}'
                    : '- ${NumberFormat.simpleCurrency().format(widget.entry.amount)}',
                style: TextStyle(fontSize: 14,
                    color: (widget.entry.transactionType == TransactionType.DEPOSIT && widget.entry.statementType == StatementType.ASSET ||
                        widget.entry.transactionType == TransactionType.WITHDRAWAL && widget.entry.statementType == StatementType.LIABILITY)
                        ? Colors.greenAccent
                        : Colors.redAccent),
              )
            ]),
          ),
        ),
      ),
    );
  }
}