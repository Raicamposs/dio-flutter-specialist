import 'package:flutter/material.dart';

class ResizedBox extends StatelessWidget {
  const ResizedBox({
    Key? key,
    this.maxWidth,
    this.minWidth = 0.0,
    required this.widthFactor,
    this.child,
  }) : super(key: key);

  final double? maxWidth;
  final double? minWidth;
  final double widthFactor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final widthFactor =
        MediaQuery.sizeOf(context).width * this.widthFactor / 100;
    return Container(
      height: 40,
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? double.infinity,
        minWidth: minWidth ?? 0.0,
      ),
      width: widthFactor,
      child: child,
    );
  }
}
