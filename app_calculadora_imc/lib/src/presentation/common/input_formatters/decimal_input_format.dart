// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/services.dart';

class DecimalInputFormatter extends TextInputFormatter {
  DecimalInputFormatter({this.decimalDigits = 2})
      : assert(
          decimalDigits >= 0,
          'Decimal Digits should to be bigger or equal 0 . Actual: $decimalDigits',
        );

  final int decimalDigits;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (decimalDigits > 0 &&
        newValue.text.length == 1 &&
        newValue.text.startsWith(',')) {
      return const TextEditingValue(
        text: '0,',
        selection: TextSelection.collapsed(offset: 2),
      );
    }

    final regex = decimalDigits > 0
        ? RegExp(r'(0|\d{1,12})(\,)?(\d{0,' + decimalDigits.toString() + '})')
        : RegExp(r'(\d{1,12})');

    final newText = regex.stringMatch(newValue.text) ?? '';

    if (newText != newValue.text) return oldValue;

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
