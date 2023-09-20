import 'package:flutter/material.dart';

abstract final class AppColors {
  static const MaterialColor primary = MaterialColor(
    0xFF9E77ED,
    <int, Color>{
      25: Color(0xFFFCFAFF),
      50: Color(0xFFF9F5FF),
      100: Color(0xFFF4EBFF),
      200: Color(0xFFE9D7FE),
      300: Color(0xFFD6BBFB),
      400: Color(0xFFB692F6),
      500: Color(0xFF9E77ED),
      600: Color(0xFF7F56D9),
      700: Color(0xFF6941C6),
      800: Color(0xFF53389E),
      900: Color(0xFF42307D),
      950: Color(0xFF2C1C5F),
    },
  );

  static const MaterialColor gray = MaterialColor(
    0xFF667085,
    <int, Color>{
      025: Color(0xFFFCFCFD),
      050: Color(0xFFF9FAFB),
      100: Color(0xFFF2F4F7),
      200: Color(0xFFEAECF0),
      300: Color(0xFFD0D5DD),
      400: Color(0xFF98A2B3),
      500: Color(0xFF667085),
      600: Color(0xFF475467),
      700: Color(0xFF344054),
      800: Color(0xFF1D2939),
      900: Color(0xFF101828),
      950: Color(0xFF0C111D),
    },
  );

  static const MaterialColor error = MaterialColor(
    0xFFF04438,
    <int, Color>{
      025: Color(0xFFFFFBFA),
      050: Color(0xFFFEF3F2),
      100: Color(0xFFFEE4E2),
      200: Color(0xFFFECDCA),
      300: Color(0xFFFDA29B),
      400: Color(0xFFF97066),
      500: Color(0xFFF04438),
      600: Color(0xFFD92D20),
      700: Color(0xFFB42318),
      800: Color(0xFF912018),
      900: Color(0xFF7A271A),
      950: Color(0xFF55160C),
    },
  );

  static const MaterialColor warning = MaterialColor(
    0xFFF79009,
    <int, Color>{
      025: Color(0xFFFFFCF5),
      050: Color(0xFFFFFAEB),
      100: Color(0xFFFEF0C7),
      200: Color(0xFFFEDF89),
      300: Color(0xFFFEC84B),
      400: Color(0xFFFDB022),
      500: Color(0xFFF79009),
      600: Color(0xFFDC6803),
      700: Color(0xFFB54708),
      800: Color(0xFF93370D),
      900: Color(0xFF7A2E0E),
      950: Color(0xFF4E1D09),
    },
  );

  static const MaterialColor success = MaterialColor(
    0xFF17B26A,
    <int, Color>{
      025: Color(0xFFF6FEF9),
      050: Color(0xFFECFDF3),
      100: Color(0xFFDCFAE6),
      200: Color(0xFFABEFC6),
      300: Color(0xFF75E0A7),
      400: Color(0xFF47CD89),
      500: Color(0xFF17B26A),
      600: Color(0xFF079455),
      700: Color(0xFF067647),
      800: Color(0xFF085D3A),
      900: Color(0xFF074D31),
      950: Color(0xFF053321),
    },
  );
}
