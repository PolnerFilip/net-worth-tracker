enum AssetType {
  CRYPTOCURRENCY, REAL_ESTATE, STOCK, CASH
}

extension ConstructionClassExtension on AssetType {
  String? get name {
    switch (this) {
      case AssetType.CRYPTOCURRENCY:
        return "Cryptocurrency";
      case AssetType.REAL_ESTATE:
        return "Real Estate";
      case AssetType.STOCK:
        return "Stocks";
      case AssetType.CASH:
        return "Cash";
      default:
        return null;
    }
  }
}

AssetType? getAssetFromName(String name) {
  switch (name) {
    case 'Cryptocurrency':
      return AssetType.CRYPTOCURRENCY;
    case 'Real Estate':
      return AssetType.REAL_ESTATE;
    case 'Stocks':
      return AssetType.STOCK;
    case 'Cash':
      return AssetType.CASH;
    default:
      return null;
  }
}