// ignore_for_file: public_member_api_docs, sort_constructors_first
class Email {
  final String _value;
  final String _label;

  Email(String value, [String? label])
      : _value = value.trim().toLowerCase(),
        _label = label ?? '';

  static RegExp get regex {
    return RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
  }

  bool get isValid {
    return regex.hasMatch(_value);
  }

  String get value {
    return _value;
  }

  String get label {
    return _label;
  }

  @override
  String toString() => 'Email($_value, $_label)';
}
