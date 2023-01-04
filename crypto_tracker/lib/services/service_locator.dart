import 'package:crypto_tracker/services/firebase_service.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> initializeLocators() async {
  serviceLocator.registerSingleton<FirebaseService>(FirebaseService());
}