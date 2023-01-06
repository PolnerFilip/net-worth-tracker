import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.leading,
    required this.trailing
  }) : super(key: key);

  final String leading;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        leading,
        style: const TextStyle(fontWeight: FontWeight.bold),),
      trailing: Text(
        trailing.toString(),
        style: const TextStyle(fontWeight: FontWeight.bold),),
    );
  }
}
