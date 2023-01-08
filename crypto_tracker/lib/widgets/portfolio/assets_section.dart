import 'dart:collection';

import 'package:crypto_tracker/services/asset_observer.dart';
import 'package:crypto_tracker/widgets/portfolio/list_item.dart';
import 'package:crypto_tracker/widgets/portfolio/section_title.dart';
import 'package:crypto_tracker/widgets/portfolio/toggle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypto_tracker/utils/show_amount_notifier.dart';
import 'package:crypto_tracker/core/res/icons.dart';
import 'package:intl/intl.dart';

class AssetsSection extends StatefulWidget {
  const AssetsSection({Key? key}) : super(key: key);

  @override
  State<AssetsSection> createState() => _AssetsSectionState();
}

class _AssetsSectionState extends State<AssetsSection> {
  bool displayPercentage = true;
  String _assetSum =  "\$";
  Map<String, String> _specificAssetAmounts = HashMap();
  Map<String, String> _specificAssetPercentages = HashMap();
  ShowNotifier showNotifier = ShowNotifier();

  @override
  void initState() {
    AssetObserver.instance.addListener(() {
      setState(() {hideShow();});
    });
    hideShow();
    showNotifier.addListener(() => mounted
        ? setState(() {hideShow();})
        : null
    );
    super.initState();
  }

  void hideShow() {
    if (ShowNotifier().show) {
      _assetSum = NumberFormat.simpleCurrency(decimalDigits: 0).format(AssetObserver.instance.assetSum);
      _specificAssetAmounts = AssetObserver.instance.specificAssetAmounts.map((key, value) => MapEntry(key, NumberFormat.simpleCurrency(decimalDigits: 0).format(value)));
      _specificAssetPercentages = AssetObserver.instance.specificAssetPercentages.map((key, value) => MapEntry(key, value.toString()));
    } else {
      String char = '\u2731';
      _assetSum = char * 4;
      _specificAssetAmounts = AssetObserver.instance.specificAssetAmounts.map((key, value) => MapEntry(key, char * 4));
      _specificAssetPercentages = AssetObserver.instance.specificAssetPercentages.map((key, value) => MapEntry(key, char * 4));
    }
  }

  @override
  void dispose() {
    showNotifier.removeListener(() => setState(() {hideShow();}));
    super.dispose();
  }

  void toggleDisplayPercentage(int index) {
    setState(() {
      displayPercentage = index == 0 ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          isAssets: true,
          leading: 'Assets',
          trailing: _assetSum
        ),
          if (displayPercentage)
            for (MapEntry<String, String> entry in _specificAssetPercentages.entries)
              ListItem(leading: Icon(CustomIcons.getAssetIcon(entry.key)), title: entry.key, trailing: entry.value + (ShowNotifier().show ? '%' : ''), displayPercentage: displayPercentage)
          else
            for (MapEntry<String, String> entry in _specificAssetAmounts.entries)
              ListItem(leading: Icon(CustomIcons.getAssetIcon(entry.key)), title: entry.key, trailing: entry.value, displayPercentage: displayPercentage),
        const SizedBox(height: 20),
        Toggle(callback: toggleDisplayPercentage),
      ],
    );
  }
}
