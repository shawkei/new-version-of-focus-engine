import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Soft, calm palette
  static const Color primary = Color(0xFF6B8E7B);
  static const Color primaryLight = Color(0xFFA8C5B5);
  static const Color accent = Color(0xFFF4A261);
  static const Color background = Color(0xFFF7F5F2);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color success = Color(0xFF6B8E7B);
  static const Color error = Color(0xFFE07A5F);

  // Dark mode colors
  static const Color darkBackground = Color(0xFF1A1A2E);
  static const Color darkSurface = Color(0xFF16213E);
  static const Color darkTextPrimary = Color(0xFFE8E8E8);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: background,
        colorScheme: const ColorScheme.light(
          primary: primary,
          secondary: accent,
          surface: surface,
          background: background,
          onPrimary: Colors.white,
          onSurface: textPrimary,
          error: error,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.w300,
            letterSpacing: -2,
            color: textPrimary,
          ),
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: textSecondary,
            height: 1.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: textSecondary,
            height: 1.4,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: surface,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: textPrimary,
          centerTitle: true,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: darkBackground,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8FB996),
          secondary: Color(0xFFF4A261),
          surface: darkSurface,
          background: darkBackground,
          onPrimary: Colors.white,
          onSurface: darkTextPrimary,
          error: Color(0xFFE07A5F),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.w300,
            letterSpacing: -2,
            color: darkTextPrimary,
          ),
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: darkTextPrimary,
          ),
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: darkTextPrimary,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: darkTextSecondary,
            height: 1.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: darkTextSecondary,
            height: 1.4,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8FB996),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: darkSurface,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: darkTextPrimary,
          centerTitle: true,
        ),
      );
}
