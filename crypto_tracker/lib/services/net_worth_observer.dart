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
  String rank = '';

  void getNetWorthAndRank() async {
    fetchNetWorth().then((value) => notifyListeners());
  }

  Future<void> fetchNetWorth() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserModel userModel = await userRepository.getUserWithTransactions(user.email ?? '');
      netWorth = _calculateNetWorth(userModel.transactions ?? []);
      _calculateRank(netWorth);
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
            assetDepositTransactions += transaction.amount.toInt();
          } else {
            liabilityDepositTransactions += transaction.amount.toInt();
          }
        } else {
          if (transaction.statementType == StatementType.ASSET) {
            assetWithdrawalTransactions += transaction.amount.toInt();
          } else {
            liabilityWithdrawalTransactions += transaction.amount.toInt();
          }
        }
      }
    }
    netWorth = assetDepositTransactions - liabilityDepositTransactions - assetWithdrawalTransactions + liabilityWithdrawalTransactions;
    return netWorth;
  }

  void _calculateRank(int netWorth) {
    if(netWorth <= 10000) {
      rank = 'Brookie';
    } else if(netWorth <= 50000) {
      rank = 'Novice';
    } else if(netWorth <= 100000) {
      rank = 'Student';
    } else if(netWorth <= 500000) {
      rank = 'Hustler';
    } else if(netWorth <= 1000000) {
      rank = 'Coach';
    } else if(netWorth <= 10000000) {
      rank = 'Guru';
    } else if(netWorth <= 100000000) {
      rank = 'Tycoon';
    } else if(netWorth <= 500000000) {
      rank = 'Top G';
    }
  }
}
