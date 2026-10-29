import 'package:flutter/material.dart';

class AppSystemTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF0C7FEA),
      brightness: Brightness.light,
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF0C7FEA),
      brightness: Brightness.dark,
    ),
  );
}
