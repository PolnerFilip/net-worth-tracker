import 'package:crypto_tracker/widgets/net_worth_add/form/add_form.dart';
import 'package:crypto_tracker/widgets/net_worth_add/toggle.dart';
import 'package:crypto_tracker/widgets/net_worth_add/top_bar.dart';
import 'package:flutter/material.dart';

class NetWorthAdd extends StatefulWidget {
  const NetWorthAdd({Key? key}) : super(key: key);

  @override
  State<NetWorthAdd> createState() => _NetWorthAddState();
}

class _NetWorthAddState extends State<NetWorthAdd> {
  final List<bool> _selected = <bool>[true, false];
  bool vertical = false;
  final List<Widget> pages = <Widget>[
    const Text('Asset'),
    const Text('Liability'),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Column(children: [
          const TopBar(),
          const Toggle(),
          const AddForm()
        ]),
      ),
    );
  }
}
