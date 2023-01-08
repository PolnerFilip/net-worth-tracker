import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_tracker/models/transaction.dart';
import 'package:crypto_tracker/network/repositories/user_repository.dart';
import 'package:crypto_tracker/services/asset_observer.dart';
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
}
