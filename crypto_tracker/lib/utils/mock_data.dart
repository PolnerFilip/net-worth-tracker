import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/models/transaction_type.dart';

import '../models/transaction.dart';

List<Transaction> transactionHistory = [
  Transaction(DateTime.utc(2023, 1, 3), AssetType.CRYPTOCURRENCY, 2500, TransactionType.DEPOSIT),
  Transaction(DateTime.utc(2023, 1, 3), AssetType.STOCK, 2200, TransactionType.WITHDRAWL),
  Transaction(DateTime.utc(2023, 1, 2), AssetType.CASH, 1000, TransactionType.DEPOSIT),
  Transaction(DateTime.utc(2023, 1, 2), AssetType.CRYPTOCURRENCY, 2000, TransactionType.WITHDRAWL),
  Transaction(DateTime.utc(2023, 1 , 2), AssetType.CASH, 499, TransactionType.DEPOSIT),
  Transaction(DateTime.utc(2022, 12, 13), AssetType.REAL_ESTATE, 100000, TransactionType.DEPOSIT),
  Transaction(DateTime.utc(2022, 12, 13), AssetType.REAL_ESTATE, 220000, TransactionType.DEPOSIT),
  Transaction(DateTime.utc(2022, 10, 4), AssetType.CRYPTOCURRENCY, 1100, TransactionType.WITHDRAWL),
  Transaction(DateTime.utc(2022, 8, 7), AssetType.STOCK, 200, TransactionType.DEPOSIT),
  Transaction(DateTime.utc(2022, 8, 7), AssetType.CRYPTOCURRENCY, 1100, TransactionType.WITHDRAWL),
  Transaction(DateTime.utc(2022, 10, 4), AssetType.CRYPTOCURRENCY, 1100, TransactionType.DEPOSIT),
];