enum  TransactionType {
  DEPOSIT, WITHDRAWAL
}

extension TransactionTypeExtension on TransactionType {
  String? get name {
    switch (this) {
      case TransactionType.DEPOSIT:
        return "Deposit";
      case TransactionType.WITHDRAWAL:
        return "Withdrawal";
      default:
        return null;
    }
  }
}

