class CryptoAsset {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice;

  CryptoAsset(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.image,
      required this.currentPrice});

  factory CryptoAsset.fromJson(Map<String, dynamic> json) {
    return CryptoAsset(
        id: json['id'],
        symbol: json['symbol'],
        name: json['name'],
        image: json['image'],
        currentPrice: json['current_price']
    );
  }

  @override
  String toString() => symbol.toUpperCase();
}
