import 'package:crypto_tracker/core/res/color.dart';
import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/models/liability_type.dart';
import 'package:crypto_tracker/models/statement_type.dart';
import 'package:crypto_tracker/models/transaction.dart';
import 'package:crypto_tracker/models/transaction_type.dart';
import 'package:crypto_tracker/network/repositories/transaction_repository.dart';
import 'package:crypto_tracker/network/repositories/user_repository.dart';
import 'package:crypto_tracker/services/asset_observer.dart';
import 'package:crypto_tracker/services/liability_observer.dart';
import 'package:crypto_tracker/services/service_locator.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/amount_input.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/asset_type_dropdown.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/date_selector.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/description_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class WithdrawForm extends StatefulWidget {
  const WithdrawForm({Key? key, required this.statementType, required this.assetType})
      : super(key: key);

  final StatementType statementType;
  final dynamic assetType;

  @override
  State<WithdrawForm> createState() => _WithdrawFormState();
}

class _WithdrawFormState extends State<WithdrawForm> {
  final _formKey = GlobalKey<FormState>();
  final _transactionRepository = serviceLocator<TransactionRepository>();
  final _userRepository = serviceLocator<UserRepository>();
  late dynamic _assetType;
  late double _currentHolding;
  late String _assetTypeName;
  double _amount = 0;
  DateTime _date = DateTime.now();
  String _description = '';

  @override
  void initState() {
    _assetType = widget.assetType;
    if (widget.statementType == StatementType.ASSET) {
      AssetType assetType = _assetType as AssetType;
      _assetTypeName = assetType.name!;
      _currentHolding = AssetObserver.instance.specificAssetAmounts[_assetTypeName]!;
    } else {
      LiabilityType liabilityType = _assetType as LiabilityType;
      _assetTypeName = liabilityType.name!;
      _currentHolding = LiabilityObserver.instance.specificLiabilityAmounts[_assetTypeName]!;
    }
    super.initState();
  }

  void _setAmount(double amount) {
    setState(() {
      _amount = amount;
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
              padding: const EdgeInsets.only(bottom: 20, top: 20),
              child: Text("Withdraw " + _assetTypeName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: AmountInput(callback: _setAmount),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(NumberFormat.simpleCurrency().format(_currentHolding)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: DateSelector(callback: _setDate),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: DescriptionField(callback: _setDescription),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: SizedBox(
                width: 80.w,
                child: MaterialButton(
                  color: AppColors.cardColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  onPressed: () async {
                    if (_currentHolding < _amount) {
                      print("Error");
                    } else {
                      if (_formKey.currentState!.validate()) {
                        await _transactionRepository.createTransaction(
                            TransactionModel(
                                timestamp: _date,
                                assetType: _assetType,
                                amount: _amount,
                                transactionType: TransactionType.WITHDRAWAL,
                                statementType: widget.statementType),
                            _userRepository.userId ?? '');
                      }
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Withdraw'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
