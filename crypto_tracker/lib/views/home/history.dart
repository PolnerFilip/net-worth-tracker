import 'package:crypto_tracker/utils/mock_data.dart';
import 'package:crypto_tracker/widgets/history/history_list_view.dart';
import 'package:crypto_tracker/widgets/shared/net_worth_tile.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(children: [
            NetWorthTile(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
              child: HistoryListView(entries: transactionHistory),
            )
          ])),
    );
  }
}
