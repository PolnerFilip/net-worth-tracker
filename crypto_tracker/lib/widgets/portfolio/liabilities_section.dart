import 'package:crypto_tracker/widgets/portfolio/list_item.dart';
import 'package:crypto_tracker/widgets/portfolio/section_title.dart';
import 'package:crypto_tracker/widgets/portfolio/toggle.dart';
import 'package:flutter/material.dart';

class LiabilitiesSection extends StatefulWidget {
  const LiabilitiesSection({Key? key}) : super(key: key);

  @override
  State<LiabilitiesSection> createState() => _LiabilitiesSectionState();
}

class _LiabilitiesSectionState extends State<LiabilitiesSection> {
  bool displayPercentage = true;

  void callback(int index) {
    setState(() {
      displayPercentage = index == 0 ? true : false;
    });
    print(index);
  }

  @override
  void initState() {
    print(displayPercentage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
            leading: 'Liabilities',
            trailing: 20000
        ),
        ListItem(
          leading: Icon(Icons.currency_bitcoin),
          title: 'Cryptocurrency',
          trailing: 49,
          displayPercentage: displayPercentage,
        ),
        ListItem(
          leading: Icon(Icons.money_sharp),
          title: 'Cash',
          trailing: 21,
          displayPercentage: displayPercentage,
        ),
        ListItem(
          leading: Icon(Icons.house_sharp),
          title: 'Real-Estate',
          trailing: 49,
          displayPercentage: displayPercentage,
        ),
        ListItem(
          leading: Icon(Icons.show_chart),
          title: 'Stocks',
          trailing: 12,
          displayPercentage: displayPercentage,
        ),
        SizedBox(height: 20),
        Toggle(callback: callback),
      ],
    );
  }
}
