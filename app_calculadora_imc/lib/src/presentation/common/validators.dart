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
      if (reg.hasMatch(v ?? '')) return null;
      return message;
    });
    return this;
  }

  Validators length(int min, String message) {
    _validators.add((v) {
      if (v?.isEmpty ?? true) return null;
      if ((v?.length ?? 0) < min) return message;
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
