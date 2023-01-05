import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:crypto_tracker/models/transaction.dart';
import '../../models/user.dart';

class TransactionRepository {
  final _db = FirebaseFirestore.instance;

  createTransaction(TransactionModel transaction, UserModel user) {
    _db.collection('Users').doc(user.id).collection("Transactions").add(transaction.toJson()).whenComplete(() => debugPrint('Transaction added'));
  }
}
