import 'package:crypto_tracker/network/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';

import '../network/repositories/transaction_repository.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> initializeLocators() async {
  serviceLocator.registerSingleton<UserRepository>(UserRepository());
  serviceLocator.registerSingleton<TransactionRepository>(TransactionRepository());
}