import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_tracker/models/user.dart';
import 'package:crypto_tracker/models/transaction.dart';
import 'package:flutter/material.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) {
    _db.collection('Users').add(user.toJson()).whenComplete(() => debugPrint('User created'));
  }

  Future<UserModel> getUserWithTransactions(String email) async {
    final snapshot = await _db.collection("Users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    final transactionSnapshot = await _db.collection("Users").doc(userData.id).collection("Transactions").get();
    userData.transactions = transactionSnapshot.docs.map((e) => TransactionModel.fromSnapshot(e)).toList();
    return userData;
  }
}
