import 'package:crypto_tracker/services/asset_observer.dart';
import 'package:crypto_tracker/services/liability_observer.dart';
import 'package:crypto_tracker/utils/show_amount_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({Key? key, required this.leading, required this.trailing, required this.isAssets}) : super(key: key);

  final String leading;
  final String trailing;
  final bool isAssets;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Text(leading, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        trailing: Text((ShowNotifier().show) ?
          NumberFormat.simpleCurrency().format(
              isAssets
                  ? AssetObserver.instance.assetSum
                  : LiabilityObserver.instance.liabilitySum
              ): '\u2731' * 6,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}
