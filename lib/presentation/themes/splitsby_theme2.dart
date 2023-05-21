import 'package:flutter/material.dart';

class SplitsbyTheme2 extends ColorScheme {
  const SplitsbyTheme2()
      : super(
            background: Colors.white,
            onBackground: Colors.black,
            error: Colors.red,
            errorContainer: const Color(0xFFAA4451),
            onError: Colors.white,
            primaryContainer: const Color(0xFFD5C6E0),
            onPrimaryContainer: const Color(0xFF000000),
            onPrimary: Colors.black,
            primary: const Color(0xFFD5C6E0),
            secondary: Colors.black,
            onSecondary: const Color(0xFFDDDAE9),
            secondaryContainer: const Color(0xFFDFD7E2),
            onSecondaryContainer: Colors.black,
            brightness: Brightness.light,
            surface: const Color(0xFFF5E6E8),
            tertiary: const Color(0xFFA3B6E3),
            tertiaryContainer: Colors.greenAccent,
            onInverseSurface: Colors.greenAccent,
            onTertiary: Colors.greenAccent,
            onTertiaryContainer: Colors.greenAccent,
            surfaceTint: Colors.greenAccent,
            surfaceVariant: Colors.greenAccent,
            inversePrimary: Colors.greenAccent,
            onSurface: Colors.black);
}
