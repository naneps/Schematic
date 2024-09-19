import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/utils/input_currenrcy_formatter.dart';

/// Enum representing different currency types.
enum CurrencyType {
  idr, // Indonesian Rupiah
  usd, // United States Dollar
  eur, // Euro
  gbp, // British Pound Sterling
  aud, // Australian Dollar
  cad, // Canadian Dollar
  chf, // Swiss Franc
  jpy, // Japanese Yen
  cny, // Chinese Yuan
  sgd, // Singapore Dollar
  hkd, // Hong Kong Dollar
}

class InputCurrency extends StatefulWidget {
  final CurrencyType currencyType;
  final String? label;
  final String? initialValue;
  final TextEditingController? controller;
  final bool formatNumberWhenChanged;
  final void Function(String)? onChanged;

  const InputCurrency({
    super.key,
    this.label = 'Amount',
    this.initialValue,
    required this.currencyType,
    this.controller,
    this.onChanged,
    this.formatNumberWhenChanged = true,
  });

  @override
  State<InputCurrency> createState() => _InputCurrencyState();
}

class _InputCurrencyState extends State<InputCurrency> {
  late TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CurrencyFormatter(widget.currencyType),
      ],
      textInputAction: TextInputAction.send,
      onChanged: (value) {
        if (widget.onChanged != null) {
          if (widget.formatNumberWhenChanged) {
            final formatter = CurrencyFormatter(widget.currencyType);
            final formattedValue = formatter.formatValue(value);
            widget.onChanged!(formattedValue);
          } else {
            // replace , with empty string
            value = value.replaceAll(RegExp(r','), '');
            widget.onChanged!(value);
          }
        }
      },
      decoration: InputDecoration(
        labelText: widget.label,
        prefixText: '${widget.currencyType.symbol} ',
        prefixStyle: Get.textTheme.labelMedium,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      _formatInitialValue(widget.initialValue!);
    }
  }

  void _formatInitialValue(String value) {
    final formatter = CurrencyFormatter(widget.currencyType);
    final formattedValue = formatter.formatValue(value);
    _controller.text = formattedValue;
  }
}

extension CurrencyTypeExtension on CurrencyType {
  String get name {
    switch (this) {
      case CurrencyType.idr:
        return 'Indonesian Rupiah';
      case CurrencyType.usd:
        return 'United States Dollar';
      case CurrencyType.eur:
        return 'Euro';
      case CurrencyType.gbp:
        return 'British Pound Sterling';
      case CurrencyType.aud:
        return 'Australian Dollar';
      case CurrencyType.cad:
        return 'Canadian Dollar';
      case CurrencyType.chf:
        return 'Swiss Franc';
      case CurrencyType.jpy:
        return 'Japanese Yen';
      case CurrencyType.cny:
        return 'Chinese Yuan';
      case CurrencyType.sgd:
        return 'Singapore Dollar';
      case CurrencyType.hkd:
        return 'Hong Kong Dollar';
    }
  }

  /// Returns the currency symbol for the currency type.
  String get symbol {
    switch (this) {
      case CurrencyType.idr:
        return 'Rp';
      case CurrencyType.usd:
        return '\$';
      case CurrencyType.eur:
        return '€';
      case CurrencyType.gbp:
        return '£';
      case CurrencyType.aud:
        return 'A\$';
      case CurrencyType.cad:
        return 'C\$';
      case CurrencyType.chf:
        return 'CHF';
      case CurrencyType.jpy:
        return '¥';
      case CurrencyType.cny:
        return '¥';
      case CurrencyType.sgd:
        return 'S\$';
      case CurrencyType.hkd:
        return 'HK\$';
    }
  }

  String shortName() {
    switch (this) {
      case CurrencyType.idr:
        return 'IDR';
      case CurrencyType.usd:
        return 'USD';
      case CurrencyType.eur:
        return 'EUR';
      case CurrencyType.gbp:
        return 'GBP';
      case CurrencyType.aud:
        return 'AUD';
      case CurrencyType.cad:
        return 'CAD';
      case CurrencyType.chf:
        return 'CHF';
      case CurrencyType.jpy:
        return 'JPY';
      case CurrencyType.cny:
        return 'CNY';
      case CurrencyType.sgd:
        return 'SGD';
      case CurrencyType.hkd:
        return 'HKD';
    }
  }
}
