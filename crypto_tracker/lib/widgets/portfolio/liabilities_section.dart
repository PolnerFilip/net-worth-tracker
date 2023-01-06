import 'dart:collection';
import 'package:crypto_tracker/services/liability_observer.dart';
import 'package:crypto_tracker/widgets/portfolio/list_item.dart';
import 'package:crypto_tracker/widgets/portfolio/section_title.dart';
import 'package:crypto_tracker/widgets/portfolio/toggle.dart';
import 'package:flutter/material.dart';
import 'package:crypto_tracker/utils/show_amount_notifier.dart';
import 'package:crypto_tracker/core/res/icons.dart';

class LiabilitiesSection extends StatefulWidget {
  const LiabilitiesSection({Key? key}) : super(key: key);

  @override
  State<LiabilitiesSection> createState() => _LiabilitiesSectionState();
}

class _LiabilitiesSectionState extends State<LiabilitiesSection> {
  bool displayPercentage = true;
  String _liabilitySum =  "\$";
  Map<String, String> _specificLiabilityAmounts = HashMap();
  Map<String, String> _specificLiabilityPercentages = HashMap();
  ShowNotifier showNotifier = ShowNotifier();

  @override
  void initState() {
    LiabilityObserver.instance.addListener(() {
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
      _liabilitySum = '\$${LiabilityObserver.instance.liabilitySum}';
      _specificLiabilityAmounts = LiabilityObserver.instance.specificLiabilityAmounts.map((key, value) => MapEntry(key, value.toString()));
      _specificLiabilityPercentages = LiabilityObserver.instance.specificLiabilityPercentages.map((key, value) => MapEntry(key, value.toString()));
    } else {
      String char = '\u2731';
      _liabilitySum = char * 4;
      _specificLiabilityAmounts = LiabilityObserver.instance.specificLiabilityAmounts.map((key, value) => MapEntry(key, char * 4));
      _specificLiabilityPercentages = LiabilityObserver.instance.specificLiabilityPercentages.map((key, value) => MapEntry(key, char * 4));
    }
  }

  @override
  void dispose() {
    showNotifier.removeListener(() => setState(() {hideShow();}));
    super.dispose();
  }
  void callback(int index) {
    setState(() {
      displayPercentage = index == 0 ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
            leading: 'Liabilities',
            trailing: _liabilitySum
        ),
        if (displayPercentage)
          for (MapEntry<String, String> entry in _specificLiabilityPercentages.entries)
            ListItem(leading: Icon(CustomIcons.getAssetIcon(entry.key)), title: entry.key, trailing: entry.value, displayPercentage: displayPercentage)
        else
          for (MapEntry<String, String> entry in _specificLiabilityAmounts.entries)
            ListItem(leading: Icon(CustomIcons.getAssetIcon(entry.key)), title: entry.key, trailing: entry.value, displayPercentage: displayPercentage),
        const SizedBox(height: 20),
        Toggle(callback: callback),
      ],
    );
  }
}
