import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: const Color(0xFF1f646f),
  primaryColorLight: const Color(0xFF14684E),
  secondaryHeaderColor: const Color(0xFFaaa818),
  brightness: Brightness.dark,
  shadowColor: Colors.black.withValues(alpha:0.4),
  cardColor: const Color(0xFF29292D),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color:Color(0xFF8dbac3)),
    titleSmall: TextStyle(color: Color(0xFF25282D)),
  ),
  dialogTheme: const DialogThemeData(surfaceTintColor: Colors.black),
  dividerColor: const Color(0x2A9E9E9E),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: const Color(0xFF689da7),
    onPrimary: const Color(0xFF689da7),
    secondary: const Color(0xFFaaa818),
    onSecondary: const Color(0xfffaf84f),
    error: Colors.redAccent,
    onError: Colors.redAccent,
    surface: const Color(0xFF212121),
    onSurface:  Colors.white70,
    onSecondaryContainer: const Color(0xFFff8672),
    shadow: Colors.black.withValues(alpha:0.4),
  ),
);
