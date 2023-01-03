import 'package:crypto_tracker/models/transaction.dart';
import 'package:crypto_tracker/widgets/history/history_list_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({Key? key, required this.entries}) : super(key: key);

  final List<Transaction> entries;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: entries.length,
      itemBuilder: (context, index) {
        Widget separator = const SizedBox();
        int diff = calculateDifference(entries[index].createdAt);
        if (index != 0) {
          if (entries[index].createdAt != entries[index - 1].createdAt) {
            separator = Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 5, 0, 25),
              child: Text(
                checkLabel(diff, entries[index]),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            );
          }
        } else {
          separator = Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 25),
            child: Text(
              checkLabel(diff, entries[index]),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [separator, HistoryListItem(entry: entries[index])],
        );
      },
    );
  }
}

int calculateDifference(DateTime date) {
  DateTime now = DateTime.now();
  return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
}

String checkLabel(int diff, Transaction item) {
  String label = '';
  if (diff == 0) {
    label = 'Today';
  } else if (diff == -1) {
    label = 'Yesterday';
  } else {
    label = DateFormat("MMM d, y").format(item.createdAt);
  }
  return label;
}
