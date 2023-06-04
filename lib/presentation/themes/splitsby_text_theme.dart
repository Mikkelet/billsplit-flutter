import 'package:flutter/material.dart';

class SplitsbyTextTheme extends TextTheme {
  static const double baseFontSize = 12;

  const SplitsbyTextTheme()
      : super(
          bodySmall: const TextStyle(fontSize: baseFontSize * 0.6),
          bodyMedium: const TextStyle(fontSize: baseFontSize * 0.8),
          bodyLarge: const TextStyle(fontSize: baseFontSize),
          labelSmall: const TextStyle(fontSize: baseFontSize * 1.1),
          labelMedium: const TextStyle(fontSize: baseFontSize * 1.2),
          labelLarge: const TextStyle(fontSize: baseFontSize * 1.3),
          headlineSmall: const TextStyle(fontSize: baseFontSize * 1.4),
          headlineMedium: const TextStyle(fontSize: baseFontSize * 1.5),
          headlineLarge: const TextStyle(fontSize: baseFontSize * 1.6),
          titleSmall: const TextStyle(fontSize: baseFontSize * 1.7),
          titleMedium: const TextStyle(fontSize: baseFontSize * 1.8),
          titleLarge: const TextStyle(fontSize: baseFontSize * 1.9),
          displaySmall: const TextStyle(fontSize: baseFontSize * 2),
          displayMedium: const TextStyle(fontSize: baseFontSize * 2.1),
          displayLarge: const TextStyle(fontSize: baseFontSize * 2.5),
        );

  // generic
  static TextStyle textFieldStyle(BuildContext context) =>
      TextStyle(fontSize: Theme.of(context).textTheme.labelMedium?.fontSize);

  static TextStyle textFieldErrorText(BuildContext context) => TextStyle(
      color: Colors.red,
      fontSize: Theme.of(context).textTheme.labelMedium?.fontSize);

  static TextStyle textFieldHintStyle(BuildContext context) => TextStyle(
      fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
      color: Theme.of(context).colorScheme.inversePrimary);

  static TextStyle textFieldHintError(BuildContext context) => TextStyle(
      fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
      color: Theme.of(context).colorScheme.error);

  static TextStyle signOutButtonText(BuildContext context) => TextStyle(
      fontSize: Theme.of(context).textTheme.labelSmall?.fontSize,
      color: Theme.of(context).colorScheme.onError);

  static TextStyle fabText(BuildContext context) => TextStyle(
      fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
      fontFamily: "Montserrat");

  // Home page
  static TextStyle splitsbyTitle(BuildContext context) => TextStyle(
      fontSize: Theme.of(context).textTheme.displayLarge?.fontSize);

  // group view
  static TextStyle _groupViewDebt(BuildContext context) =>
      TextStyle(fontSize: Theme.of(context).textTheme.labelLarge?.fontSize);

  static TextStyle groupViewPositiveDebt(BuildContext context) =>
      _groupViewDebt(context).copyWith(
        color: Colors.green,
      );

  static TextStyle groupViewNegativeDebt(BuildContext context) =>
      _groupViewDebt(context).copyWith(color: Colors.red);

  static TextStyle groupViewDebtCurrency(BuildContext context) => TextStyle(
      fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
      color: Theme.of(context).colorScheme.inversePrimary);

  // currency picker dialog
  static TextStyle currencyTitle(BuildContext context) => TextStyle(
      fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
      color: Theme.of(context).colorScheme.onBackground,
      fontWeight: FontWeight.w700);

  static TextStyle exchangeRateLabel(BuildContext context) => TextStyle(
      fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
      color: Theme.of(context).colorScheme.inversePrimary);
}
