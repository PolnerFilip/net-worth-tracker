import 'package:crypto_tracker/models/crypto_asset.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/amount_input.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/crypto_field/crypto_amount_input.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/crypto_field/crypto_selector.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/res/color.dart';

class CryptoInput extends StatefulWidget {
  const CryptoInput({Key? key, required this.assetCallback, required this.quantityCallback, this.cryptoAsset}) : super(key: key);

  final Function assetCallback;
  final Function quantityCallback;
  final CryptoAsset? cryptoAsset;

  @override
  State<CryptoInput> createState() => _CryptoInputState();
}

class _CryptoInputState extends State<CryptoInput> {
  double _priceUsd = 0;
  CryptoAsset? _cryptoAsset;
  double _quantity = 0;

  void _setPriceUsd(double quantity) {
    print(quantity);
    setState(() {
      _priceUsd = quantity * _cryptoAsset!.currentPrice;
      _quantity = quantity;
    });
    widget.quantityCallback(quantity);
  }

  void _setCryptoAsset(CryptoAsset cryptoAsset) {
    setState(() {
      _cryptoAsset = cryptoAsset;
      _priceUsd = _quantity * _cryptoAsset!.currentPrice;
    });
    print(_cryptoAsset);
    widget.assetCallback(cryptoAsset);
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          height: 8.h,
          width: 80.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoSelector(callback: _setCryptoAsset),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: CryptoAmountInput(callback: _setPriceUsd, enabled: widget.cryptoAsset == null ? false : true),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Container(
            height: 3.h,
            width: 80.w,
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Text(
                NumberFormat.simpleCurrency().format(_priceUsd),
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        )
      ],
    );
  }
}
