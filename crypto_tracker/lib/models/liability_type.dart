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