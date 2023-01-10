import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_tracker/models/crypto_asset.dart';
import 'package:crypto_tracker/models/transaction.dart';
import 'package:crypto_tracker/models/transaction_type.dart';
import 'package:crypto_tracker/network/repositories/user_repository.dart';
import 'package:crypto_tracker/services/asset_observer.dart';
import 'package:crypto_tracker/services/crypto_service.dart';
import 'package:crypto_tracker/services/liability_observer.dart';
import 'package:crypto_tracker/services/net_worth_observer.dart';
import 'package:crypto_tracker/services/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionRepository {
  final _db = FirebaseFirestore.instance;

  createTransaction(TransactionModel transaction, String userId) {
    _db.collection('Users').doc(userId).collection("Transactions").add(transaction.toJson()).whenComplete(() => debugPrint('Transaction added'));
    serviceLocator<UserRepository>().getUserWithTransactions(FirebaseAuth.instance.currentUser?.email ?? '');
    NetWorthObserver.instance.getNetWorthAndRank();
    AssetObserver.instance.getAssets();
    LiabilityObserver.instance.getLiabilities();
  }

  Map<String, double> getCryptoQuantities() {
    List<TransactionModel> transactions = serviceLocator<UserRepository>().transactions;
    Map<String, double> cryptoQunatities = {};
    try {
      for (TransactionModel transaction in transactions) {
        if (transaction.cryptoQuantity != null) {
          String asset = transaction.cryptoAsset!;
          if (cryptoQunatities.containsKey(asset)) {
            transaction.transactionType == TransactionType.DEPOSIT
            ? cryptoQunatities.update(asset, (value) => value + transaction.cryptoQuantity!)
            : cryptoQunatities.update(asset, (value) => value - transaction.cryptoQuantity!);
          } else {
            cryptoQunatities[asset] = transaction.transactionType == TransactionType.DEPOSIT ? transaction.cryptoQuantity! : -transaction.cryptoQuantity!;
          }
        }
      }
    } catch (err) {
      print(err.toString());
    }

    cryptoQunatities.removeWhere((key, value) => value == 0.000);

    print(cryptoQunatities);
    return cryptoQunatities;
  }
}
