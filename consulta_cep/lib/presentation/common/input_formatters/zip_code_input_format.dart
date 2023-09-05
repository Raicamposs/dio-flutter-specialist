import 'package:flutter/services.dart';

class ZipCodeInputFormatter extends TextInputFormatter {
  final int maxLength = 9;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length >= maxLength) {
      return oldValue;
    }

    final zipCodeMask = RegExp(r'(\d{5})(\d{1,3})');
    final onlyNumbers = newValue.text.replaceAll(RegExp(r'/\D/g'), '');
    final text = onlyNumbers.replaceAllMapped(
      zipCodeMask,
      (Match m) => '${m[1]}-${m[2]}',
    );

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(
        offset: text.length,
      ),
    );
  }
}
