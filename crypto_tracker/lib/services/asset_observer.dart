import 'dart:collection';

import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/models/statement_type.dart';
import 'package:crypto_tracker/services/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../models/transaction_type.dart';
import '../models/user.dart';
import '../network/repositories/user_repository.dart';

class AssetObserver with ChangeNotifier {
  AssetObserver._privateConstructor();

  static final AssetObserver instance = AssetObserver._privateConstructor();

  final UserRepository userRepository = serviceLocator<UserRepository>();
  int assetSum = 0;
  Map<String, double> specificAssetAmounts = HashMap();
  Map<String, int> specificAssetPercentages = HashMap();

  void getAssets() async {
    fetchAssets().then((value) => notifyListeners());
  }

  Future<void> fetchAssets() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserModel userModel = await userRepository.getUserWithTransactions(user.email ?? '');
      assetSum = _calculateAssetSum(userModel.transactions ?? []);
      specificAssetAmounts = _calculateSpecificAssetAmounts(userModel.transactions ?? []);
      specificAssetPercentages = _calculateSpecificAssetPercentages(specificAssetAmounts);
    }
  }

  int _calculateAssetSum(List<TransactionModel> transactions) {
    int assetSum = 0;
    int assetDepositTransactions = 0;
    int assetWithdrawalTransactions = 0;
    if (transactions != []) {
      for (TransactionModel transaction in transactions) {
        if (transaction.statementType == StatementType.ASSET) {
          if (transaction.transactionType == TransactionType.DEPOSIT) {
            assetDepositTransactions += transaction.amount.toInt();
          } else {
            assetWithdrawalTransactions += transaction.amount.toInt();
          }
        }
      }
    }
    assetSum = assetDepositTransactions - assetWithdrawalTransactions;
    return assetSum;
  }

  Map<String, double> _calculateSpecificAssetAmounts(List<TransactionModel> transactions) {
    Map<String, double> specificAssetAmounts = HashMap();
    for (var assetType in AssetType.values) {
      specificAssetAmounts[assetType.name!] = 0;
    }
    if (transactions != []) {
      for (TransactionModel transaction in transactions) {
        if (transaction.statementType == StatementType.ASSET) {
          AssetType assetType = transaction.assetType as AssetType;
          if (transaction.transactionType == TransactionType.DEPOSIT) {
            specificAssetAmounts.update(assetType.name!, (value) => value + transaction.amount, ifAbsent: () => transaction.amount);
          } else {
            specificAssetAmounts.update(assetType.name!, (value) => value - transaction.amount, ifAbsent: () => 0);
          }
        }
      }
    }
    return specificAssetAmounts;
  }

  Map<String, int> _calculateSpecificAssetPercentages(Map<String, double> specificAssetAmounts) {
    double sum = 0;
    specificAssetAmounts.values.forEach((value) => sum += value);
    if (sum != 0) {
      return specificAssetAmounts.map((key, value) => MapEntry(key, ((value/sum)*100).round()));
    } else {
      return specificAssetAmounts.map((key, value) => MapEntry(key, 0));
    }
  }
}
