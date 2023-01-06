import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_tracker/models/transaction.dart';
import 'package:crypto_tracker/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRepository extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  List<TransactionModel> transactions = [];
  String? userId;

  createUser(UserModel user) {
    _db.collection('Users').add(user.toJson()).whenComplete(() => debugPrint('User created'));
  }

  Future<String> getUserId() async {
    final snapshot = await _db.collection("Users").where("email", isEqualTo: FirebaseAuth.instance.currentUser?.email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    userId = userData.id ?? '';
    return userId!;
  }

  Future<UserModel> getUserWithTransactions(String email) async {
    final snapshot = await _db.collection("Users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    final transactionSnapshot = await _db.collection("Users").doc(userData.id).collection("Transactions").orderBy('timestamp', descending: true).get();
    userData.transactions = transactionSnapshot.docs.map((e) => TransactionModel.fromSnapshot(e)).toList();
    transactions = userData.transactions ?? [];
    notifyListeners();
    return userData;
  }


}
