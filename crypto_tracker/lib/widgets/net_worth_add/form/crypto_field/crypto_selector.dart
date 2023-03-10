import 'package:crypto_tracker/network/repositories/transaction_repository.dart';
import 'package:crypto_tracker/services/crypto_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/res/color.dart';
import '../../../../models/crypto_asset.dart';


class CryptoSelector extends StatefulWidget {
  const CryptoSelector({
    Key? key,
    required this.callback,
    required this.isWithdrawal
  }) : super(key: key);

  final Function callback;
  final bool isWithdrawal;

  @override
  State<CryptoSelector> createState() => _CryptoSelectorState();
}

class _CryptoSelectorState extends State<CryptoSelector> {
  List<String> list = List.filled(10, 'hahahah');
  List<CryptoAsset> cryptoAssets = [];

  @override
  void initState() {
    widget.isWithdrawal ? _getUserCryptos() : _getAllCryptos();
    super.initState();
  }

  void _getAllCryptos() async {
    cryptoAssets =
    CryptoService.cryptoAssets.isEmpty
        ? await CryptoService.instance.getCryptoAssets()
        : CryptoService.cryptoAssets;
    setState(() {});
    print(cryptoAssets[0].image);
  }

  void _getUserCryptos() {
    cryptoAssets = CryptoService.instance.getUserCryptos();
    print('ASSETS');
    print(cryptoAssets);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      width: 30.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.cardColor.withOpacity(0.2),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownSearch<CryptoAsset>(
              items: cryptoAssets,
              compareFn: (i, s) => i == s,
              onChanged: (value) {
                widget.callback(value);
              },
              popupProps: PopupPropsMultiSelection.modalBottomSheet(
                  title: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Select crypto asset',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  showSelectedItems: true,
                  showSearchBox: true,
                  itemBuilder: _customPopupItemBuilderExample2,
                  modalBottomSheetProps: ModalBottomSheetProps(backgroundColor: AppColors.bgColor)),
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 20, top: 15),
                  
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _customPopupItemBuilderExample2(
  BuildContext context,
  CryptoAsset item,
  bool isSelected,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: AppColors.cardColor.withOpacity(0.2),
    ),
    child: ListTile(
      trailing: Image.network(
        item.image,
        height: 30,
      ),
      selected: isSelected,
      title: Text(item.symbol.toUpperCase()),
      subtitle: Text(item.name),
    ),
  );
}