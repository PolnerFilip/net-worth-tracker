import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/models/statement_type.dart';
import 'package:crypto_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/res/color.dart';
import '../../models/transaction_type.dart';
import '../../utils/show_amount_notifier.dart';

class HistoryListItem extends StatefulWidget {
  const HistoryListItem({Key? key, required this.entry}) : super(key: key);

  final TransactionModel entry;

  @override
  State<HistoryListItem> createState() => _HistoryListItemState();
}

class _HistoryListItemState extends State<HistoryListItem> {
  ShowNotifier showNotifier = ShowNotifier();

  @override
  void initState() {
    showNotifier.addListener(() => mounted ? setState(() {}) : null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SizedBox(
        height: 70,
        child: DecoratedBox(
          decoration: BoxDecoration(color: AppColors.cardColor.withOpacity(0.2), borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: const EdgeInsets.only(right: 15.0), child: getImage(widget.entry.assetType)),
                    Text(
                      widget.entry.assetType.name.toString(),
                      style: const TextStyle(fontWeight: FontWeight.normal, letterSpacing: 0.7, fontSize: 15.5),
                    )
                  ],
                ),
              ),
              Text(
                (ShowNotifier().show == true)
                    ? (widget.entry.transactionType == TransactionType.DEPOSIT)
                        ? '+ ${NumberFormat.simpleCurrency().format(widget.entry.amount)}'
                        : '- ${NumberFormat.simpleCurrency().format(widget.entry.amount)}'
                    : '\u2731' * 6,
                style:
                    TextStyle(fontSize: 14, color: (ShowNotifier().show == true) ? (widget.entry.transactionType == TransactionType.DEPOSIT) ? Colors.greenAccent : Colors.redAccent : Colors.grey),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

Widget getImage(AssetType type) {
  switch (type) {
    case AssetType.CRYPTOCURRENCY:
      return Image.asset(
        'assets/bitcoin.png',
        width: 25,
        color: Colors.orange,
      );
    case AssetType.REAL_ESTATE:
      return Image.asset(
        'assets/real_estate.png',
        width: 25,
        color: Colors.grey[400],
      );
    case AssetType.STOCK:
      return Image.asset(
        'assets/stock.png',
        width: 25,
        color: Colors.blueGrey,
      );
    case AssetType.CASH:
      return Image.asset(
        'assets/cash.png',
        width: 25,
        color: Colors.green,
      );
  }
}
