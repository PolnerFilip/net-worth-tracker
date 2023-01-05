enum StatementType {
  ASSET, LIABILITY
}

extension StatementTypeExtension on StatementType {
  String? get name {
    switch (this) {
      case StatementType.ASSET:
        return "Asset";
      case StatementType.LIABILITY:
        return "Liability";
      default:
        return null;
    }
  }
}