import 'package:crypto_tracker/models/asset_type.dart';
import 'package:crypto_tracker/models/statement_type.dart';
import 'package:crypto_tracker/models/transaction.dart';
import 'package:crypto_tracker/models/transaction_type.dart';
import 'package:crypto_tracker/network/repositories/transaction_repository.dart';
import 'package:crypto_tracker/views/home/authentification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../network/repositories/user_repository.dart';
import '../../services/service_locator.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  final UserRepository userRepository = serviceLocator<UserRepository>();
  final TransactionRepository transactionRepository = serviceLocator<TransactionRepository>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () async{
              await FirebaseAuth.instance.signOut();
              Navigator.of(context, rootNavigator: true)
                  .pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const SignInScreen();
                  },
                ),
                    (_) => false,
              );
            },
            child: const Text('Sign Out')),
        ElevatedButton(
            onPressed: () async {
              UserModel user = await userRepository.getUserWithTransactions('gasper.lukacs@gmail.com');
              print(user.transactions);
            },
            child: const Text('Get User Info')),
        ElevatedButton(
            onPressed: () async {
              await transactionRepository.createTransaction(
                  TransactionModel(
                      timestamp: DateTime(2023, 1, 4, 3 ,5,6),
                      assetType: AssetType.CASH,
                      amount: 200,
                      transactionType: TransactionType.DEPOSIT,
                      statementType: StatementType.LIABILITY),
                  userRepository.userId ?? '');
            },
            child: const Text('Insert Transaction'))
      ],
    );
  }
}
