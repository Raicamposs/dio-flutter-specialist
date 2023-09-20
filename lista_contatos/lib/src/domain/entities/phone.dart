// ignore_for_file: public_member_api_docs, sort_constructors_first

class Phone {
  final String _value;
  final String _label;

  Phone(String value, [String? label])
      : _value = value.trim().toLowerCase(),
        _label = label ?? '';

  static RegExp get regex {
    const pattern = r'^\([1-9]{2}\) (?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$';
    return RegExp(pattern);
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
  String toString() => 'Phone($_value, $_label)';
}
