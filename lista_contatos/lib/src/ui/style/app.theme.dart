import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.colors.dart';

final textTheme = GoogleFonts.interTextTheme().apply(
  bodyColor: AppColors.gray[900],
  displayColor: AppColors.gray[900],
  decorationColor: AppColors.gray[900],
);

final colorScheme = ColorScheme.fromSeed(seedColor: AppColors.primary).copyWith(
  error: AppColors.error,
  brightness: Brightness.light,
  errorContainer: AppColors.error[300],
  primary: AppColors.primary,
  // secondary: AppColors.success,
);

final _outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: AppColors.gray[300]!),
  borderRadius: const BorderRadius.all(
    Radius.circular(8),
  ),
);

final appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  textTheme: textTheme,
  colorScheme: colorScheme,
  primarySwatch: AppColors.primary,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.gray[25],
  canvasColor: AppColors.gray[50],
  sliderTheme: SliderThemeData(
    overlayShape: SliderComponentShape.noOverlay,
  ),
  iconTheme: IconThemeData(
    color: AppColors.gray[600],
  ),
  primaryIconTheme: IconThemeData(
    color: AppColors.primary[700],
  ),
  timePickerTheme: TimePickerThemeData(
    hourMinuteTextColor: colorScheme.secondary,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: colorScheme.primary,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0.2,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: AppColors.gray[400],
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    surfaceTintColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: AppColors.gray[200]!),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: colorScheme.primary,
    disabledColor: AppColors.primary[200],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.primary[200];
        }
        return null; // Defer to the widget's default.
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.white;
        }
        return null; // Defer to the widget's default.
      }),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      side: MaterialStateProperty.resolveWith<BorderSide?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return BorderSide(
            color: AppColors.primary[25]!,
            style: BorderStyle.solid,
          );
        }
        return BorderSide(
          color: AppColors.primary[300]!,
          style: BorderStyle.solid,
        ); // Defer to the widget's default.
      }),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(
            color: AppColors.primary[300]!,
            style: BorderStyle.solid,
          ),
        ),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.primary[25];
        }
        return null; // Defer to the widget's default.
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.primary[300];
        }
        return null; // Defer to the widget's default.
      }),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.primary[200];
        }
        return null; // Defer to the widget's default.
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.white;
        }
        return null; // Defer to the widget's default.
      }),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    helperStyle: TextStyle(color: AppColors.gray[600]!),
    hintStyle: TextStyle(color: AppColors.gray[500]!),
    counterStyle: TextStyle(color: AppColors.gray[600]!),
    prefixStyle: TextStyle(color: AppColors.gray[600]!),
    suffixStyle: TextStyle(color: AppColors.gray[600]!),
    prefixIconColor: AppColors.gray[500]!,
    suffixIconColor: AppColors.gray[500]!,
    focusColor: AppColors.primary[300]!,
    errorStyle: TextStyle(color: AppColors.error[500]!),
    border: _outlineInputBorder,
    enabledBorder: _outlineInputBorder,
    focusedBorder: _outlineInputBorder.copyWith(
      borderSide: _outlineInputBorder.borderSide.copyWith(
        color: AppColors.primary[300]!,
      ),
    ),
  ),
);
