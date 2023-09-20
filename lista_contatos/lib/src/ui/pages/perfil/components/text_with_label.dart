import 'package:flutter/material.dart';

class TextWithLabel extends StatelessWidget {
  final String text;
  final String? label;

  const TextWithLabel({
    super.key,
    required this.text,
    this.label = '',
  });

  get _formattedText {
    return [text, label]
        .where((element) => (element ?? '').trim().isNotEmpty)
        .join(' • ');
  }

  @override
  Widget build(BuildContext context) {
    return Text(_formattedText);
  }
}
