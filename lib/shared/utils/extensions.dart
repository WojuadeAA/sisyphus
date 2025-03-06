import 'package:flutter/material.dart';
import 'package:sisyphus/shared/utils/utils.dart';

extension ThemeExtension on BuildContext? {
  bool isDarkMode() {
    final brightness = Theme.of(this!).brightness;
    return brightness == Brightness.dark;
  }
}

extension DoubleExtension on double? {
  String formatAsRoundedInteger() {
    return this == null ? '-' : (NumberFormat('#,##0', 'en_US').format(this));
  }

  String formatWithTwoDecimalPlaces() {
    return this == null ? '-' : (NumberFormat('#,##0.00', 'en_US').format(this));
  }
}
