// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LegendWidget extends StatelessWidget {
  const LegendWidget({
    Key? key,
    required this.color,
    required this.text,
    required this.range,
    required this.selected,
  }) : super(key: key);

  final Color color;
  final String text;
  final String range;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final selectColor = selected ? color : null;
    final fontWeight = selected ? FontWeight.bold : null;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            height: 10,
            width: 10,
            color: color,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: selectColor, fontWeight: fontWeight),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Text(
              range,
              textAlign: TextAlign.center,
              style: TextStyle(color: selectColor, fontWeight: fontWeight),
            ),
          ),
        ],
      ),
    );
  }
}
