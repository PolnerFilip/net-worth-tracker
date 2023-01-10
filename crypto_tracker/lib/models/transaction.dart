import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/models/liability_type.dart';
import 'package:crypto_tracker/models/statement_type.dart';
import 'package:crypto_tracker/models/transaction_type.dart';
import 'package:enum_to_string/enum_to_string.dart';

import 'crypto_asset.dart';

class TransactionModel {
  String? id;
  DateTime timestamp;
  dynamic assetType;
  StatementType statementType;
  double amount;
  TransactionType transactionType;
  String description;
  double? cryptoQuantity;
  String? cryptoAsset;

  TransactionModel(
      {this.id,
      required this.timestamp,
      this.assetType,
      required this.amount,
      required this.transactionType,
      required this.statementType,
      this.description = '',
      this.cryptoAsset,
      this.cryptoQuantity
      });

  toJson() {
    return {
      "timestamp": Timestamp.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch),
      "assetType": EnumToString.convertToString(assetType),
      "amount": amount,
      "transactionType": EnumToString.convertToString(transactionType),
      "statementType": EnumToString.convertToString(statementType),
      "cryptoQuantity": cryptoQuantity,
      "cryptoAsset": cryptoAsset ?? "null"
    };
  }

  factory TransactionModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    Timestamp timestamp = data?['timestamp'];
    return TransactionModel(
        id: document.id,
        timestamp: DateTime.parse(timestamp.toDate().toString()),
        assetType: data?['statementType'] == 'ASSET' ? EnumToString.fromString(AssetType.values, data?['assetType'] ?? AssetType.CASH) : EnumToString.fromString(LiabilityType.values, data?['assetType'] ?? LiabilityType.STUDENT_LOAN),
        amount: data?['amount'].toDouble(),
        transactionType: EnumToString.fromString(TransactionType.values, data?['transactionType']) ?? TransactionType.DEPOSIT,
        statementType: EnumToString.fromString(StatementType.values, data?['statementType']) ?? StatementType.ASSET,
        cryptoAsset: data?['cryptoAsset'],
        cryptoQuantity: data?['cryptoQuantity'] != null ? data!['cryptoQuantity'].toDouble() : null
    );
  }
}
