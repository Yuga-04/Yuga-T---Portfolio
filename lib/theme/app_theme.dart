import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Pure black and white color palette
  static const Color primaryBlack = Color(0xFF000000);
  static const Color deepBlack = Color(0xFF0A0A0A);
  static const Color richBlack = Color(0xFF121212);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color softWhite = Color(0xFFF5F5F5);
  static const Color glassWhite = Color(0x1AFFFFFF);
  static const Color borderWhite = Color(0x33FFFFFF);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: primaryBlack,
    primaryColor: pureWhite,
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: pureWhite,
      displayColor: pureWhite,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: pureWhite),
    ),
    cardTheme: CardThemeData(
      color: glassWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: borderWhite, width: 1),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: glassWhite,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderWhite),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderWhite),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: pureWhite, width: 2),
      ),
      labelStyle: TextStyle(color: softWhite),
      hintStyle: TextStyle(color: borderWhite),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: pureWhite,
        foregroundColor: primaryBlack,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
