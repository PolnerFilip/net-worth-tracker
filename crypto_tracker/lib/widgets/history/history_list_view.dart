import 'package:crypto_tracker/models/transaction.dart';
import 'package:crypto_tracker/utils/show_amount_notifier.dart';
import 'package:crypto_tracker/widgets/history/history_list_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryListView extends StatefulWidget {
  const HistoryListView({Key? key, required this.entries}) : super(key: key);

  final List<TransactionModel> entries;

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  final ShowNotifier showNotifier = ShowNotifier();
  // List<String> values = [];
  bool show = true;

  @override
  void initState() {
    // values = List.filled(widget.entries.length, '\u2731'*4);
    hideShow();

    showNotifier.addListener(() => mounted
        ? setState(() {hideShow();})
        : null
    );
    super.initState();
  }

  void hideShow() {
      setState(() {
        show = showNotifier.show;
      });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.entries.length,
      itemBuilder: (context, index) {
        Widget separator = const SizedBox();
        int diff = calculateDifference(widget.entries[index].timestamp);
        if (index != 0) {
          DateTime currentItemDate = DateTime(widget.entries[index].timestamp.year, widget.entries[index].timestamp.month, widget.entries[index].timestamp.day);
          DateTime previousItemDate = DateTime(widget.entries[index-1].timestamp.year, widget.entries[index-1].timestamp.month, widget.entries[index-1].timestamp.day);
          if (currentItemDate != previousItemDate) {
            separator = Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 5, 0, 25),
              child: Text(
                checkLabel(diff, widget.entries[index]),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            );
          }
        } else {
          separator = Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 25),
            child: Text(
              checkLabel(diff, widget.entries[index]),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [separator, HistoryListItem(entry: widget.entries[index], show: show)],
        );
      },
    );
  }
}

int calculateDifference(DateTime date) {
  DateTime now = DateTime.now();
  return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
}

String checkLabel(int diff, TransactionModel item) {
  String label = '';
  if (diff == 0) {
    label = 'Today';
  } else if (diff == -1) {
    label = 'Yesterday';
  } else {
    label = DateFormat("MMM d, y").format(item.timestamp);
  }
  return label;
}
