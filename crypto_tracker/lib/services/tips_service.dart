import 'dart:convert';

import 'package:crypto_tracker/widgets/tips/tip.dart';
import 'package:http/http.dart' as http;

class TipsService {
  final openAIApiKey = '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';
  static TipsService instance = TipsService();

  Future<List<Tip>> getTips() async {
    const prompt =
        'Evaluate my investment portfolio in 3 tips on how I should improve it. My portfolio is: 10% crypto, 40% stocks, 50% real estate.';
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
    return tips;

    // final completions = await openAI.completion(
    //     'Evaluate my investment portfolio in 3 tips on how I should improve it. My portfolio is: 10% crypto, 40% stocks, 50% real estate.',
    //     {maxTokens:});

    // return [Text("Tip1"), Text("Tip2")];
  }
}
