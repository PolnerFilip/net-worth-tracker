import 'dart:convert';

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
        CryptoAsset newAsset = CryptoAsset.fromJson(Map.from(asset));
        // print(newAsset.id);
        cryptoAssets.add(newAsset);
      }
    } catch (error) {
      print(error.toString());
    }
    return cryptoAssets;
  }
}