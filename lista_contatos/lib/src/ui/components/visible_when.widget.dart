import 'package:flutter/material.dart';

abstract class Visible {
  static Widget when({required bool condition, required Widget child}) {
    return Visibility(
      visible: condition,
      child: child,
    );
  }

  static Widget whenIsMobile({
    required Widget child,
    required BuildContext context,
  }) {
    return when(
      child: child,
      condition: MediaQuery.sizeOf(context).width < 600,
    );
  }

  static Widget whenIsNotMobile({
    required Widget child,
    required BuildContext context,
  }) {
    return when(
      child: child,
      condition: MediaQuery.sizeOf(context).width >= 600,
    );
  }
}
