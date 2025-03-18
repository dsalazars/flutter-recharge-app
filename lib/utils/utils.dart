import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static String formatPrice(double price) {
    return NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(price);
  }

  static void showFunctionalityInDevelopmentMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Esta funcionalidad está en desarrollo'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
