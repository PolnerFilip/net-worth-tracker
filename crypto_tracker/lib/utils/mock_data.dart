import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/models/statement_type.dart';
import 'package:crypto_tracker/models/transaction_type.dart';

import '../models/transaction.dart';

List<TransactionModel> transactionHistory = [
  TransactionModel(timestamp: DateTime.utc(2023, 1, 5, 2, 3, 4), assetType: AssetType.CRYPTOCURRENCY, amount: 2500, transactionType: TransactionType.DEPOSIT, statementType: StatementType.ASSET),
  TransactionModel(timestamp: DateTime.utc(2023, 1, 5, 3, 2, 5), assetType:AssetType.STOCK, amount:2200, transactionType: TransactionType.WITHDRAWAL, statementType: StatementType.ASSET),
  TransactionModel(timestamp: DateTime.utc(2023, 1, 2), assetType:AssetType.CASH,amount: 1000, transactionType:TransactionType.DEPOSIT, statementType: StatementType.ASSET),
  TransactionModel(timestamp: DateTime.utc(2023, 1, 2), assetType:AssetType.CRYPTOCURRENCY, amount:2000, transactionType:TransactionType.WITHDRAWAL, statementType: StatementType.ASSET),
  TransactionModel(timestamp: DateTime.utc(2023, 1 , 2), assetType:AssetType.CASH, amount:499, transactionType:TransactionType.DEPOSIT, statementType: StatementType.ASSET),
  TransactionModel(timestamp: DateTime.utc(2022, 12, 13), assetType:AssetType.REAL_ESTATE,amount: 100000, transactionType:TransactionType.DEPOSIT, statementType: StatementType.ASSET),
  TransactionModel(timestamp: DateTime.utc(2022, 12, 13), assetType:AssetType.REAL_ESTATE,amount: 220000, transactionType:TransactionType.DEPOSIT, statementType: StatementType.ASSET),
  TransactionModel(timestamp: DateTime.utc(2022, 10, 4), assetType:AssetType.CRYPTOCURRENCY, amount:1100, transactionType:TransactionType.WITHDRAWAL, statementType: StatementType.ASSET),
  TransactionModel(timestamp: DateTime.utc(2022, 8, 7), assetType:AssetType.STOCK, amount:200, transactionType:TransactionType.DEPOSIT, statementType: StatementType.ASSET),
  TransactionModel(timestamp: DateTime.utc(2022, 8, 7), assetType:AssetType.CRYPTOCURRENCY, amount:1100, transactionType:TransactionType.WITHDRAWAL, statementType: StatementType.ASSET),
  TransactionModel(timestamp: DateTime.utc(2022, 10, 4), assetType:AssetType.CRYPTOCURRENCY, amount:1100, transactionType:TransactionType.DEPOSIT, statementType: StatementType.ASSET),
];