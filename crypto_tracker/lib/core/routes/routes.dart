import 'package:crypto_tracker/views/coin.dart';
import 'package:crypto_tracker/views/home.dart';
import 'package:crypto_tracker/views/home/authentification_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const home = "/home";
  static const coinDetails = "/coin/details";
  static const signIn = "/signIn";
}

class RouterGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: ((context) => const HomeScreen()),
        );
      case Routes.coinDetails:
        return MaterialPageRoute(
          builder: ((context) => const CoinScreen()),
        );
      case Routes.signIn:
        return MaterialPageRoute(
          builder: ((context) => SignInScreen()),
        );
      default:
        return MaterialPageRoute(
          builder: ((context) => const HomeScreen()),
        );
    }
  }
}
