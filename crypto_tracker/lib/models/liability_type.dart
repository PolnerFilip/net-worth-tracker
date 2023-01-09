enum LiabilityType {
  STUDENT_LOAN, MORTGAGE, CAR_LEASE, CREDIT_CARD_DEBT
}

extension ConstructionClassExtension on LiabilityType {
  String? get name {
    switch (this) {
      case LiabilityType.STUDENT_LOAN:
        return "Student Loan";
      case LiabilityType.MORTGAGE:
        return "Mortgage";
      case LiabilityType.CAR_LEASE:
        return "Car Lease";
      case LiabilityType.CREDIT_CARD_DEBT:
        return "Credit Card Debt";
      default:
        return null;
    }
  }
}

LiabilityType? getLiabilityTypeFromName(String name) {
  switch (name) {
    case 'Student Loan':
      return LiabilityType.STUDENT_LOAN;
    case 'Mortgage':
      return LiabilityType.MORTGAGE;
    case 'Car Lease':
      return LiabilityType.CAR_LEASE;
    case 'Credit Card Debt':
      return LiabilityType.CREDIT_CARD_DEBT;
    default:
      return null;
  }
}