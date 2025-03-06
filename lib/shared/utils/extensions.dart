import 'package:flutter/material.dart';
import 'package:sisyphus/core/core.dart';
import 'package:sisyphus/shared/utils/utils.dart';

extension ThemeExtension on BuildContext? {
  bool isDarkMode() {
    final brightness = Theme.of(this!).brightness;
    return brightness == Brightness.dark;
  }

  void openBottomSheet(Widget bottomSheet) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: this!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      backgroundColor: isDarkMode() ? const Color(0xff20252B) : white,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext buildContext) {
        return bottomSheet;
      },
    );
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
