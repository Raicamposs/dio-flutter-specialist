import 'dart:convert';
import 'dart:io';

class ConsoleUtils {
  String _answer = '';

  static ConsoleUtils instance() {
    return ConsoleUtils();
  }

  ConsoleUtils white(String question) {
    print(question);
    return this;
  }

  ConsoleUtils read() {
    _answer = stdin.readLineSync(encoding: utf8) ?? "";
    return this;
  }

  double? doubleAnswer() {
    try {
      return double.parse(_answer);
    } catch (e) {
      return null;
    }
  }

  String answer() {
    return _answer;
  }
}
