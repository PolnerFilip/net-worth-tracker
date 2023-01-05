enum  TransactionType {
  DEPOSIT, WITHDRAWL
}

extension TransactionTypeExtension on TransactionType {
  String? get name {
    switch (this) {
      case TransactionType.DEPOSIT:
        return "Deposit";
      case TransactionType.WITHDRAWL:
        return "Withdrawl";
      default:
        return null;
    }
  }
}

