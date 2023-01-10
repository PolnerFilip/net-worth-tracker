import 'package:crypto_tracker/models/crypto_asset.dart';
import 'package:crypto_tracker/network/repositories/transaction_repository.dart';
import 'package:crypto_tracker/services/crypto_service.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/crypto_field/crypto_amount_input.dart';
import 'package:crypto_tracker/widgets/net_worth_add/form/crypto_field/crypto_selector.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CryptoInput extends StatefulWidget {
  const CryptoInput(
      {Key? key,
      required this.assetCallback,
      required this.quantityCallback,
      this.cryptoAsset,
      required this.isWithdrawal})
      : super(key: key);

  final Function assetCallback;
  final Function quantityCallback;
  final CryptoAsset? cryptoAsset;
  final bool isWithdrawal;

  @override
  State<CryptoInput> createState() => _CryptoInputState();
}

class _CryptoInputState extends State<CryptoInput> {
  double _priceUsd = 0;
  CryptoAsset? _cryptoAsset;
  double _quantity = 0;
  double _userHoldings = 0;

  void _setPriceUsd(double quantity) {
    print(_userHoldings);
    print("quantity" + quantity.toString());
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
      _userHoldings = widget.isWithdrawal
          ? CryptoService.instance.getCryptoHolding(cryptoAsset)
          : 0;
    });
    print(_cryptoAsset);
    widget.assetCallback(cryptoAsset);
  }

  Text _getRemainingHoldings() {
    double remainingHolding = _userHoldings - _quantity;
    return remainingHolding.isNegative
        ? const Text(
            "0.000",
            style: TextStyle(color: Colors.red),
          )
        : Text(
            remainingHolding.toStringAsFixed(3),
            style: const TextStyle(color: Colors.grey),
          );
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
              CryptoSelector(
                  callback: _setCryptoAsset, isWithdrawal: widget.isWithdrawal),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: CryptoAmountInput(
                    callback: _setPriceUsd,
                    enabled: _cryptoAsset == null ? false : true,
                    userHoldings: _userHoldings,
                    isWithdrawal: widget.isWithdrawal,
                ),
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
              child: (!widget.isWithdrawal)
                  ? Text(
                      NumberFormat.simpleCurrency().format(_priceUsd),
                      style: TextStyle(color: Colors.grey),
                    )
                  : _getRemainingHoldings(),
            ),
          ),
        ),
      ],
    );
  }
}
