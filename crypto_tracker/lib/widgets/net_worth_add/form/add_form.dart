import 'package:crypto_tracker/core/res/color.dart';
import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/models/crypto_asset.dart';
import 'package:crypto_tracker/models/statement_type.dart';
import 'package:crypto_tracker/models/transaction_type.dart';
import 'package:crypto_tracker/network/repositories/user_repository.dart';
import 'package:crypto_tracker/services/service_locator.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/amount_input.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/asset_type_dropdown.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/crypto_field/crypto_selector.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/crypto_field/crypto_input.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/date_selector.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/description_field.dart';
import 'package:crypto_tracker/widgets/net_worth_add/toggle.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../models/transaction.dart';
import '../../../models/user.dart';
import '../../../network/repositories/transaction_repository.dart';

class AddForm extends StatefulWidget {
  const AddForm({Key? key, required this.statementType
  }) : super(key: key);

  final StatementType statementType;

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  final _transactionRepository = serviceLocator<TransactionRepository>();
  final _userRepository = serviceLocator<UserRepository>();
  CryptoAsset? _cryptoAsset;
  double _cryptoQuantity = 0;
  double _amount = 0;
  AssetType _assetType = AssetType.CRYPTOCURRENCY;
  DateTime _date = DateTime.now();
  String _description = '';
  
  void _setCryptoAsset(CryptoAsset crypto) {
    setState(() {
      _cryptoAsset = crypto;
    });
  }

  void _setCryptoQuantity(double quantity) {
    setState(() {
      _cryptoQuantity = quantity;
    });
    print(_cryptoQuantity);
  }

  void _setAmount(double amount) {
    setState(() {
      _amount = amount;
    });
    print(_amount);
  }

  void _setAssetType(AssetType assetType) {
    setState(() {
      _assetType = assetType;
      if (_assetType != AssetType.CRYPTOCURRENCY) _cryptoAsset = null;
    });
    print(_cryptoAsset);
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

  void _saveToDatabase() async {
    if (_assetType == AssetType.CRYPTOCURRENCY) {
      _amount = _cryptoQuantity * _cryptoAsset!.currentPrice;
    }
    await _transactionRepository.createTransaction(
        TransactionModel(
            timestamp: _date,
            assetType: _assetType,
            amount: _amount,
            transactionType: TransactionType.DEPOSIT,
            statementType: widget.statementType,
            cryptoAsset: _cryptoAsset,
            cryptoQuantity: _cryptoQuantity == 0 ? null : _cryptoQuantity
        ),
        _userRepository.userId ?? '');
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
              child:
              _assetType == AssetType.CRYPTOCURRENCY
                  ? CryptoInput(assetCallback: _setCryptoAsset, quantityCallback: _setCryptoQuantity, cryptoAsset: _cryptoAsset,)
                  : AmountInput(callback: _setAmount),
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
                child: MaterialButton(
                  color: AppColors.cardColor,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                        _saveToDatabase();
                    }
                    print('${_cryptoQuantity} ${_cryptoAsset} ${_amount}, ${_assetType}, ${_date}, ${_description}, ${widget.statementType}');
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
