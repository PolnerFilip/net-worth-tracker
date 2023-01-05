import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/models/statement_type.dart';
import 'package:crypto_tracker/models/transaction_type.dart';


class TransactionModel {
  String? id;
  DateTime timestamp;
  AssetType assetType;
  StatementType statementType;
  int amount;
  TransactionType transactionType;
  String description;

  TransactionModel(
      {this.id, required this.timestamp, required this.assetType, required this.amount, required this.transactionType, required this.statementType, this.description = ''});

  toJson() {
    return {
      "timestamp": timestamp,
      "assetType": assetType.name,
      "amount": amount,
      "transactionType": transactionType.name,
      "statementType": statementType.name
    };
  }

  factory TransactionModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return TransactionModel(
        id: document.id,
        timestamp: data?['timestamp'],
        assetType: data?['assetType'],
        amount: data?['amount'],
        transactionType: data?['transactionType'],
        statementType: data?['statementType']);
  }
}
