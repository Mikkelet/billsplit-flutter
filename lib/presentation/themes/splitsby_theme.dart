import 'package:flutter/material.dart';

class SplitsbyTheme extends ColorScheme {
  const SplitsbyTheme()
      : super(
            background: const Color(0xFFf4f4f4),
            onBackground: Colors.black,
            error: Colors.red,
            onError: Colors.white,
            primaryContainer: const Color(0xFFD5D5D7),
            onPrimaryContainer: const Color(0xFF000000),
            onPrimary: const Color(0xFFFFFFFF),
            primary: const Color(0xFF769392),
            secondary: const Color(0xFF52d1dc),
            onSecondary: const Color(0xFF0A2F33),
            onSecondaryContainer: const Color(0xFF99E3EA),
            secondaryContainer: const Color(0xFF031011),
            brightness: Brightness.light,
            surface: Colors.white,
            onSurface: Colors.black);
}
