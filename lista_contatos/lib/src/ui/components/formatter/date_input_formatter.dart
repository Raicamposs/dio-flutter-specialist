import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final value = newValue.text.length;

    if (value > 8) {
      return oldValue;
    }

    var selectionIndex = newValue.selection.end;
    var index = 0;
    final output = StringBuffer();

    if (value >= 3) {
      output.write('${newValue.text.substring(0, index = 2)}/');
      if (newValue.selection.end >= 2) selectionIndex++;
    }
    if (value >= 5) {
      output.write('${newValue.text.substring(2, index = 4)}/');
      if (newValue.selection.end >= 4) selectionIndex++;
    }
    if (value >= index) {
      output.write(newValue.text.substring(index));
    }

    return TextEditingValue(
      text: output.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
