import 'package:crypto_tracker/services/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/statement_type.dart';
import '../models/transaction.dart';
import '../models/transaction_type.dart';
import '../models/user.dart';
import '../network/repositories/user_repository.dart';

class NetWorthObserver with ChangeNotifier {
  NetWorthObserver._privateConstructor();
  static final NetWorthObserver instance = NetWorthObserver._privateConstructor();

  final UserRepository userRepository = serviceLocator<UserRepository>();
  int netWorth = 0;

  void getNetWorth() {
    fetchNetWorth();
    notifyListeners();
  }

  void fetchNetWorth() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserModel userModel = await userRepository.getUserWithTransactions(user.email ?? '');
      netWorth = _calculateNetWorth(userModel.transactions ?? []);
    }
  }

  int _calculateNetWorth(List<TransactionModel> transactions) {
    int netWorth = 0;
    int assetDepositTransactions = 0;
    int liabilityDepositTransactions = 0;
    int assetWithdrawalTransactions = 0;
    int liabilityWithdrawalTransactions = 0;
    if (transactions != []) {
      for (TransactionModel transaction in transactions) {
        if (transaction.transactionType == TransactionType.DEPOSIT) {
          if (transaction.statementType == StatementType.ASSET) {
            assetDepositTransactions += transaction.amount;
          } else {
            liabilityDepositTransactions += transaction.amount;
          }
        } else {
          if (transaction.statementType == StatementType.ASSET) {
            assetWithdrawalTransactions += transaction.amount;
          } else {
            liabilityWithdrawalTransactions += transaction.amount;
          }
        }
      }
    }

    netWorth = assetDepositTransactions - liabilityDepositTransactions - assetWithdrawalTransactions + liabilityWithdrawalTransactions;
    return netWorth;
  }
}