import 'dart:collection';
import 'dart:ffi';

import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/models/liability_type.dart';
import 'package:crypto_tracker/models/statement_type.dart';
import 'package:crypto_tracker/services/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../models/transaction_type.dart';
import '../models/user.dart';
import '../network/repositories/user_repository.dart';

class LiabilityObserver with ChangeNotifier {
  LiabilityObserver._privateConstructor();

  static final LiabilityObserver instance = LiabilityObserver._privateConstructor();

  final UserRepository userRepository = serviceLocator<UserRepository>();
  int liabilitySum = 0;
  Map<String, double> specificLiabilityAmounts = HashMap();
  Map<String, int> specificLiabilityPercentages = HashMap();

  void getLiabilities() async {
    fetchLiabilities().then((value) => notifyListeners());
  }

  Future<void> fetchLiabilities() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserModel userModel = await userRepository.getUserWithTransactions(user.email ?? '');
      liabilitySum = _calculateLiabilitySum(userModel.transactions ?? []);
      specificLiabilityAmounts = _calculateSpecificLiabilityAmounts(userModel.transactions ?? []);
      specificLiabilityPercentages = _calculateSpecificLiabilityPercentages(specificLiabilityAmounts);
    }
  }

  int _calculateLiabilitySum(List<TransactionModel> transactions) {
    int liabilitySum = 0;
    int liabilityDepositTransactions = 0;
    int liabilityWithdrawalTransactions = 0;
    if (transactions != []) {
      for (TransactionModel transaction in transactions) {
        if (transaction.statementType == StatementType.LIABILITY) {
          if (transaction.transactionType == TransactionType.DEPOSIT) {
            liabilityDepositTransactions += transaction.amount.toInt();
          } else {
            liabilityWithdrawalTransactions += transaction.amount.toInt();
          }
        }
      }
    }
    liabilitySum = liabilityDepositTransactions - liabilityWithdrawalTransactions;
    return liabilitySum;
  }

  Map<String, double> _calculateSpecificLiabilityAmounts(List<TransactionModel> transactions) {
    Map<String, double> specificLiabilityAmounts = HashMap();
    for (var liabilityType in LiabilityType.values) {
      specificLiabilityAmounts[liabilityType.name!] = 0;
    }
    if (transactions != []) {
      for (TransactionModel transaction in transactions) {
        if (transaction.statementType == StatementType.LIABILITY) {
          if (transaction.transactionType == TransactionType.DEPOSIT) {
            specificLiabilityAmounts.update(transaction.assetType.name!, (value) => value + transaction.amount, ifAbsent: () => transaction.amount);
          } else {
            specificLiabilityAmounts.update(transaction.assetType.name!, (value) => value - transaction.amount, ifAbsent: () => 0);
          }
        }
      }
    }
    return specificLiabilityAmounts;
  }

  Map<String, int> _calculateSpecificLiabilityPercentages(Map<String, double> specificLiabilityAmounts) {
    double sum = 0;
    specificLiabilityAmounts.values.forEach((value) => sum += value);
    if (sum != 0) {
      return specificLiabilityAmounts.map((key, value) => MapEntry(key, ((value/sum)*100).round()));
    } else {
      return specificLiabilityAmounts.map((key, value) => MapEntry(key, 0));
    }
  }
}
