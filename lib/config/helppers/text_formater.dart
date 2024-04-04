//DEPENDENCIA PARA FORMATEO DE NUMERO intl

import 'package:intl/intl.dart';

class TextFormatter {
  static String textReadableNumber(double number) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '',
    ).format(number);
    return formatterNumber;
  }
}
