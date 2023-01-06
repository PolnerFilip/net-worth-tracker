import 'package:flutter/material.dart';

class CustomIcons {
  static IconData getAssetIcon(String assetName) {
    switch (assetName) {
      case "Cryptocurrency":
        return Icons.currency_bitcoin;
      case "Real Estate":
        return Icons.real_estate_agent;
      case "Cash":
        return Icons.money_sharp;
      case "Stocks":
        return Icons.show_chart;
      default:
        return Icons.question_mark;
    }
  }

  static IconData getLiabilityIcon(String liabilityName) {
    switch (liabilityName) {
      case "Student Loan":
        return Icons.school;
      case "Mortgage":
        return Icons.house_sharp;
      case "Car Lease":
        return Icons.car_crash;
      case "Credit Card Debt":
        return Icons.credit_card;
      default:
        return Icons.question_mark;
    }
  }
}