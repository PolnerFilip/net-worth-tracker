import 'dart:convert';

import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/services/asset_observer.dart';
import 'package:crypto_tracker/services/liability_observer.dart';
import 'package:crypto_tracker/widgets/tips/tip.dart';
import 'package:http/http.dart' as http;
import 'package:crypto_tracker/services/options.dart';

class TipsService {
  final openAIApiKey = optionsOpenaiAPIKey;
  static TipsService instance = TipsService();
  static List<Tip> persistentTips = [];

  Future<List<Tip>> getTips() async {
    Map<String, double> specificAssetAmounts = AssetObserver.instance.specificAssetAmounts;
    Map<String, double> specificLiabilityAmounts = LiabilityObserver.instance.specificLiabilityAmounts;
    const introPrompt = 'Give me 3 tips on how I should improve my financial position by taking into regard my assets and my liabilities.';
    final assetsPrompt = 'My assets are: ${specificAssetAmounts['Cryptocurrency']}USD Cryptocurrencies, ${specificAssetAmounts['Real Estate']}USD Real Estate, ${specificAssetAmounts['Stocks']}USD Stocks, ${specificAssetAmounts['Cash']}USD Cash.';
    final liabilitiesPrompt = 'My liabilities are: ${specificLiabilityAmounts['Student Loan']}USD Student Loan, ${specificLiabilityAmounts['Mortgage']}USD Mortgage, ${specificLiabilityAmounts['Car Lease']}USD Car Lease, ${specificLiabilityAmounts['Credit Card Debt']}USD Credit Card Debt.';
    final prompt = introPrompt + assetsPrompt + liabilitiesPrompt;
    var url = Uri.https("api.openai.com", "/v1/completions");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openAIApiKey'
      },
      body: jsonEncode({
        "model": "text-davinci-003",
        "prompt": prompt,
        'temperature': 0,
        'max_tokens': 2000,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
      }),
    );

    // Do something with the response
    Map<String, dynamic> completions = jsonDecode(response.body);

    final parsedCompletions = completions['choices'][0]['text'];
    final listOfTips = List<String>.from(parsedCompletions.split('\n'));
    List<Tip> tips = [];
    listOfTips.forEach((tip) {
      if (tip.length > 5) {
        tips.add(Tip(tipText: tip));
      }
    });

    persistentTips = tips;

    return tips;

    // final completions = await openAI.completion(
    //     'Evaluate my investment portfolio in 3 tips on how I should improve it. My portfolio is: 10% crypto, 40% stocks, 50% real estate.',
    //     {maxTokens:});

    // return [Text("Tip1"), Text("Tip2")];
  }
}
