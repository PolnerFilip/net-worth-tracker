import 'package:crypto_tracker/widgets/history/history_list_view.dart';
import 'package:crypto_tracker/widgets/shared/net_worth_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/transaction.dart';
import '../../models/user.dart';
import '../../network/repositories/user_repository.dart';
import '../../services/service_locator.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final UserRepository userRepository = serviceLocator<UserRepository>();
  List<TransactionModel> transactions = [];

  @override
  void initState() {
    userRepository.addListener(() => mounted
        ? setState(() {
            _loadTransactionHistory();
          })
        : null);
    userRepository.transactions.isEmpty ? _loadTransactionHistory() : transactions = userRepository.transactions;
    super.initState();
  }

  void _loadTransactionHistory() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserModel userModel = await userRepository.getUserWithTransactions(user.email ?? '');
      setState(() {
        transactions = userModel.transactions ?? [];
      });
    }
  }



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
            const NetWorthTile(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: HistoryListView(entries: transactions),
            )
          ])),
    );
  }
}
