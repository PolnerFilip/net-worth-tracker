import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/models/statement_type.dart';
import 'package:crypto_tracker/models/transaction_type.dart';
import 'package:enum_to_string/enum_to_string.dart';

class TransactionModel {
  String? id;
  DateTime timestamp;
  AssetType assetType;
  StatementType statementType;
  double amount;
  TransactionType transactionType;
  String description;

  TransactionModel(
      {this.id,
      required this.timestamp,
      required this.assetType,
      required this.amount,
      required this.transactionType,
      required this.statementType,
      this.description = ''});

  toJson() {
    return {
      "timestamp": Timestamp.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch),
      "assetType": EnumToString.convertToString(assetType),
      "amount": amount,
      "transactionType": EnumToString.convertToString(transactionType),
      "statementType": EnumToString.convertToString(statementType),
    };
  }

  factory TransactionModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    Timestamp timestamp = data?['timestamp'];
    return TransactionModel(
        id: document.id,
        timestamp: DateTime.parse(timestamp.toDate().toString()),
        assetType: EnumToString.fromString(AssetType.values, data?['assetType']) ?? AssetType.CASH,
        amount: data?['amount'].toDouble(),
        transactionType: EnumToString.fromString(TransactionType.values, data?['transactionType']) ?? TransactionType.DEPOSIT,
        statementType: EnumToString.fromString(StatementType.values, data?['statementType']) ?? StatementType.ASSET);
  }
}
