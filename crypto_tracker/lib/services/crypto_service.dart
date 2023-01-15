import 'dart:convert';

import 'package:crypto_tracker/network/repositories/transaction_repository.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../models/crypto_asset.dart';

class CryptoService {
  static CryptoService instance = CryptoService();
  static List<CryptoAsset> cryptoAssets = [];

  Future<List<CryptoAsset>> getCryptoAssets() async {
    var url = Uri.https(
        "api.coingecko.com", "api/v3/coins/markets", {
          'vs_currency': 'usd',
          'order': 'market_cap_desc',
          'per_page': '500'
        });
    Response response;
    try {
      final response = await http.get(url);
      List<dynamic> completions = jsonDecode(response.body);
      for (dynamic asset in completions) {
        print(Map.from(asset)['current_price'] is int);
        CryptoAsset newAsset = CryptoAsset.fromJson(Map.from(asset));
        // print(newAsset.id);
        cryptoAssets.add(newAsset);
      }
    } catch (error) {
      print(error.toString());
    }
    print(cryptoAssets);
    return cryptoAssets;
  }

  CryptoAsset getCryptoFromSymbol(String symbol) {
    print("Symbol:" + symbol.toLowerCase());
    return cryptoAssets.firstWhere((element) => element.symbol == symbol.toLowerCase());
  }

  List<CryptoAsset> getUserCryptos() {
    Map<String, double> userCryptos = TransactionRepository().getCryptoQuantities();
    List<CryptoAsset> assets = [];
    for (String key in userCryptos.keys) {
      assets.add(getCryptoFromSymbol(key));
    }
    return assets;
  }

  double getCryptoHolding(CryptoAsset asset) {
    Map<String, double> holdings = TransactionRepository().getCryptoQuantities();
    return holdings[asset.symbol.toUpperCase()]!;
  }
}