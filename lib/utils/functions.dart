import 'package:intl/intl.dart';

class Functions {
  static String formatDouble(double value) {
    return value.toStringAsFixed(1);
  }

  static String formatInt(int value) {
    return NumberFormat('#,###').format(value);
  }
}
