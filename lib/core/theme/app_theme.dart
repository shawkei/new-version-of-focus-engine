import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Focus Engine Theme System
/// 
/// Design Philosophy:
/// - Soft, calm colors that reduce cognitive load
/// - High contrast for accessibility
/// - Consistent spacing using 4px grid
/// - Rounded corners for friendly feel

class AppColors {
  // Primary Palette - Soft Teal/Green
  static const Color primary = Color(0xFF2D9CDB);
  static const Color primaryLight = Color(0xFFE3F2FD);
  static const Color primaryDark = Color(0xFF1A6B9A);

  // Secondary - Warm Coral for accents
  static const Color secondary = Color(0xFFFF6B6B);
  static const Color secondaryLight = Color(0xFFFFE5E5);

  // Success - Soft Green
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFFE8F5E9);

  // Background Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  // Dark Mode
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkSurfaceVariant = Color(0xFF334155);

  // Text Colors
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textInverse = Colors.white;

  // Dark Text
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);

  // Utility
  static const Color divider = Color(0xFFE2E8F0);
  static const Color shadow = Color(0x1A000000);
  static const Color overlay = Color(0x80000000);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        background: AppColors.background,
        error: AppColors.secondary,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Inter',
      textTheme: _textTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      cardTheme: _cardTheme,
      appBarTheme: _appBarTheme,
      bottomSheetTheme: _bottomSheetTheme,
      dialogTheme: _dialogTheme,
      dividerTheme: _dividerTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.darkSurface,
        background: AppColors.darkBackground,
        error: AppColors.secondary,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.darkTextPrimary,
        onBackground: AppColors.darkTextPrimary,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      fontFamily: 'Inter',
      textTheme: _darkTextTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      cardTheme: _darkCardTheme,
      appBarTheme: _darkAppBarTheme,
      bottomSheetTheme: _darkBottomSheetTheme,
      dialogTheme: _darkDialogTheme,
      dividerTheme: _darkDividerTheme,
    );
  }

  // Text Themes
  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      letterSpacing: -1.5,
    ),
    displayMedium: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      letterSpacing: -1,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      letterSpacing: -0.5,
    ),
    headlineLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    headlineMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    headlineSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
      height: 1.5,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
      height: 1.5,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textTertiary,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    ),
  );

  static const TextTheme _darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      color: AppColors.darkTextPrimary,
      letterSpacing: -1.5,
    ),
    displayMedium: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: AppColors.darkTextPrimary,
      letterSpacing: -1,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.darkTextPrimary,
      letterSpacing: -0.5,
    ),
    headlineLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.darkTextPrimary,
    ),
    headlineMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.darkTextPrimary,
    ),
    headlineSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.darkTextPrimary,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.darkTextPrimary,
      height: 1.5,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.darkTextSecondary,
      height: 1.5,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textTertiary,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.darkTextPrimary,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.darkTextSecondary,
    ),
  );

  // Button Themes
  static final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  );

  static final OutlinedButtonThemeData _outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      side: const BorderSide(color: AppColors.primary, width: 2),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  // Card Theme
  static final CardTheme _cardTheme = CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    color: AppColors.surface,
    margin: EdgeInsets.zero,
  );

  static final CardTheme _darkCardTheme = CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    color: AppColors.darkSurface,
    margin: EdgeInsets.zero,
  );

  // AppBar Theme
  static const AppBarTheme _appBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.textPrimary,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
  );

  static const AppBarTheme _darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.darkTextPrimary,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.darkTextPrimary,
      fontFamily: 'Inter',
    ),
  );

  // Bottom Sheet Theme
  static final BottomSheetThemeData _bottomSheetTheme = BottomSheetThemeData(
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    elevation: 8,
  );

  static final BottomSheetThemeData _darkBottomSheetTheme = BottomSheetThemeData(
    backgroundColor: AppColors.darkSurface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    elevation: 8,
  );

  // Dialog Theme
  static final DialogTheme _dialogTheme = DialogTheme(
    backgroundColor: AppColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    elevation: 8,
  );

  static final DialogTheme _darkDialogTheme = DialogTheme(
    backgroundColor: AppColors.darkSurface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    elevation: 8,
  );

  // Divider Theme
  static const DividerThemeData _dividerTheme = DividerThemeData(
    color: AppColors.divider,
    thickness: 1,
    space: 1,
  );

  static const DividerThemeData _darkDividerTheme = DividerThemeData(
    color: AppColors.darkSurfaceVariant,
    thickness: 1,
    space: 1,
  );
}

/// Spacing constants following 4px grid
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

/// Animation durations
class AppAnimations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);
}
