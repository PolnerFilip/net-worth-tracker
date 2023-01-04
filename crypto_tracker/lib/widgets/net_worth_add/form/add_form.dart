import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/amount_input.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/asset_type_dropdown.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/date_selector.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/description_field.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddForm extends StatefulWidget {
  const AddForm({Key? key}) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  int? _amount;
  AssetType? _assetType;
  DateTime? _date;
  String? _description;

  void _setAmount(int amount) {
    setState(() {
      _amount = amount;
    });
  }

  void _setAssetType(AssetType assetType) {
    setState(() {
      _assetType = assetType;
    });
  }

  void _setDate(DateTime date) {
    setState(() {
      _date = date;
    });
  }

  void _setDescription(String description) {
    setState(() {
      _description = description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: AmountInput(callback: _setAmount),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AssetTypeDropdown(callback: _setAssetType),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: DateSelector(callback: _setDate),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: DescriptionField(callback: _setDescription),
            )),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Container(
                width: 80.w,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Add'),
                ),
              ),
            ),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
