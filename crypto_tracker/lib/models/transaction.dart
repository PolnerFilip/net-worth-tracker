import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/models/transaction_type.dart';

class Transaction {
  DateTime createdAt;
  AssetType type;
  int value;
  TransactionType transactionType;

  Transaction(this.createdAt, this.type, this.value, this.transactionType);
}