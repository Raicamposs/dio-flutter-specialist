import 'package:flutter/material.dart';

const _borderSide = BorderSide(
  color: Color.fromRGBO(230, 235, 242, 1),
  width: 1,
);

class GroupWidget extends StatelessWidget {
  const GroupWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(241, 245, 249, 1),
        border: Border(
          top: _borderSide,
          bottom: _borderSide,
        ),
      ),
      child: Text(
        title.toUpperCase(),
      ),
    );
  }
}
