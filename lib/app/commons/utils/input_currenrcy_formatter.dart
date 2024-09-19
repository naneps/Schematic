import 'package:flutter/services.dart';
import 'package:schematic/app/commons/ui/inputs/input_currency.dart';

class CurrencyFormatter extends TextInputFormatter {
  final CurrencyType currencyType;
  CurrencyFormatter(this.currencyType);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    if (newText.isEmpty) {
      return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    // Remove all non-digit characters
    newText = newText.replaceAll(RegExp(r'\D'), '');

    // Apply currency symbol based on the currency type
    switch (currencyType) {
      case CurrencyType.idr:
        newText = _formatCurrency(newText);
        break;
      case CurrencyType.usd:
      case CurrencyType.eur:
      case CurrencyType.gbp:
      case CurrencyType.aud:
      case CurrencyType.cad:
      case CurrencyType.chf:
      case CurrencyType.jpy:
      case CurrencyType.cny:
      case CurrencyType.sgd:
      case CurrencyType.hkd:
        newText = _formatCurrency(newText);
        break;
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String formatValue(String value) {
    return _formatCurrency(value.replaceAll(RegExp(r'\D'), ''));
  }

  String _formatCurrency(String value) {
    if (value.isEmpty) return '0';

    // Format the value with thousands separator
    int intValue = int.parse(value);
    return intValue.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match match) => '${match[1]},');
  }
}
