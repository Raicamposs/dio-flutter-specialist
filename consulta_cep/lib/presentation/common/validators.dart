import 'package:flutter/material.dart';

class Validators {
  late List<FormFieldValidator<String?>> _validators;

  Validators._() {
    _validators = [];
  }

  static Validators init() {
    return Validators._();
  }

  Validators required(String message) {
    _validators.add((value) {
      if (value == null || value.isEmpty) return message;
      return null;
    });
    return this;
  }

  Validators regex(RegExp reg, String message) {
    _validators.add((v) {
      if (v?.isEmpty ?? true) return null;
      if (reg.hasMatch(v ?? '')) return null;
      return message;
    });
    return this;
  }

  Validators length(int length, String message) {
    _validators.add((v) {
      if (v?.isEmpty ?? true) return null;
      if ((v?.length ?? 0) != length) return message;
      return null;
    });

    return this;
  }

  Validators minLength(int min, String message) {
    _validators.add((v) {
      if (v?.isEmpty ?? true) return null;
      if ((v?.length ?? 0) < min) return message;
      return null;
    });

    return this;
  }

  Validators maxLength(int max, String message) {
    _validators.add((v) {
      if (v?.isEmpty ?? true) return null;
      if ((v?.length ?? 0) > max) return message;
      return null;
    });

    return this;
  }

  Validators min(double min, String message) {
    _validators.add((v) {
      final value = double.tryParse(v.toString().replaceAll(',', '.')) ?? 0.0;
      if (value < min) {
        return message;
      }
      return null;
    });

    return this;
  }

  Validators max(double max, String message) {
    _validators.add((v) {
      final value = double.tryParse(v.toString().replaceAll(',', '.')) ?? 0.0;
      if (value > max) {
        return message;
      }
      return null;
    });

    return this;
  }

  Validators number(String message) {
    return regex(RegExp(r'^[0-9]+$'), message);
  }

  Validators justLetters(String message) {
    return regex(RegExp(r'(^[a-zA-Z ]*$)'), message);
  }

  Validators zipCode(String message) {
    return regex(RegExp(r'(^[\d]{5}-[\d]{3}$)'), message);
  }

  Validators email(String message) {
    const String regexEmail =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    return regex(RegExp(regexEmail), message);
  }

  FormFieldValidator<String> build() {
    return (value) {
      for (final validator in _validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}
