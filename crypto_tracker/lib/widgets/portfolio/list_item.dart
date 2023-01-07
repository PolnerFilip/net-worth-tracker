import 'package:crypto_tracker/core/res/color.dart';
import 'package:crypto_tracker/widgets/portfolio/withdraw_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  const ListItem(
      {Key? key,
      this.leading,
      required this.title,
      required this.trailing,
      required this.trailingAlternative,
      required this.displayPercentage,
      })
      : super(key: key);

  final Widget? leading;
  final String title;
  final String trailing;
  final Widget trailingAlternative;
  final bool displayPercentage;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late Widget _trailing;
  late Widget _amount;
  bool _showWithdraw = false;
  Color _tileColor = AppColors.cardColor.withOpacity(0.2);

  @override
  void initState() {
    _amount = Text(
      widget.trailing.toString(),
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
    _trailing = _amount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: AppColors.cardColor.withOpacity(0.2)),
        height: 50,
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (_showWithdraw) {
                _trailing = widget.trailingAlternative;
                _tileColor = const Color.fromARGB(100, 244, 54, 30);
              } else {
                _trailing = _amount;
                _tileColor = AppColors.cardColor.withOpacity(0.2);
              }
              _showWithdraw = !_showWithdraw;
            });
          },
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            leading: widget.leading,
            tileColor: _tileColor,
            title: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15.5),
            ),
            trailing: _trailing,
            dense: true,
          ),
        ),
      ),
    );
  }
}
