import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Satoshi',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: appBlack,
      scaffoldBackgroundColor: const Color(0xffF8F8F9),
      iconTheme: const IconThemeData(
        color: appBlack,
      ),
      cardColor: white,
      shadowColor: const Color(0xffF1F1F1),
      appBarTheme: const AppBarTheme(
        backgroundColor: white,
        elevation: 0,
      ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: white,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: blackTint2,
        labelColor: rockBlack,
      ),
      textTheme: const TextTheme().apply(
        bodyColor: appBlack,
        displayColor: appBlack,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          padding: const EdgeInsets.all(8),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: appBlack,
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: 'Satoshi',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: white,
      brightness: Brightness.dark,
      iconTheme: const IconThemeData(
        color: white,
      ),
      cardColor: appBlack,
      shadowColor: cardStroke,
      scaffoldBackgroundColor: rockBlack,
      appBarTheme: const AppBarTheme(
        backgroundColor: appBlack,
        elevation: 0,
      ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: rockBlack,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: white,
        labelColor: white,
      ),
      textTheme: const TextTheme().apply(
        fontFamily: 'Satoshi',
        bodyColor: white,
        displayColor: white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          padding: const EdgeInsets.all(8),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: white,
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
    );
  }
}
