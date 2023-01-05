import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_tracker/models/transaction.dart';

class UserModel {
  String? id;
  String email;
  int currentRank;
  List<TransactionModel>? transactions;

  UserModel({this.id, required this.email, this.currentRank = 1, this.transactions = const []});

  toJson() {
    return {"email": email, "currentRank": currentRank};
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return UserModel(
      id: document.id,
      email: data?['email'],
      currentRank: data?['currentRank'],
    );
  }
}
