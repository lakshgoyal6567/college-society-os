import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primary = Color(0xFFCA4D4B);
  static const Color primaryContainer = Color(0xFFD88A89);
  static const Color secondary = Color(0xFFA76561);
  static const Color secondaryContainer = Color(0xFFE0C7C6);
  static const Color tertiary = Color(0xFF006765);
  static const Color tertiaryFixedDim = Color(0xFFE9C400); // Warning/Pending
  static const Color neutral = Color(0xFF857372);

  // Surfaces
  static const Color surface = Color(0xFFFBF8FF);
  static const Color surfaceContainerLow = Color(0xFFF4F2FC);
  static const Color surfaceContainerHighest = Color(0xFFE3E1EA);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);

  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF1A1B22);
  static const Color onSurfaceVariant = Color(0xFF454652);
  static const Color outlineVariant = Color(0xFFC5C5D4);

  // Additional Containers for Admin/Profile
  static const Color tertiaryContainer = Color(0xFFCCE8E7);
  static const Color onTertiaryContainer = Color(0xFF002020);
  static const Color onSecondaryContainer = Color(0xFF410002);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: surfaceContainerLow,
    colorScheme: const ColorScheme.light(
      primary: primary,
      primaryContainer: primaryContainer,
      secondary: secondary,
      secondaryContainer: secondaryContainer,
      tertiary: tertiary,
      surface: surface,
      onSurface: onSurface,
      onSurfaceVariant: onSurfaceVariant,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.manrope(
        color: onSurface,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.manrope(
        color: onSurface,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.manrope(
        color: onSurface,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: GoogleFonts.manrope(
        color: onSurface,
        fontWeight: FontWeight.w800,
      ),
      headlineMedium: GoogleFonts.manrope(
        color: onSurface,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: GoogleFonts.manrope(
        color: onSurface,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: GoogleFonts.inter(
        color: onSurface,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.inter(
        color: onSurface,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.inter(
        color: onSurface,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.inter(
        color: onSurfaceVariant,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: GoogleFonts.inter(
        color: onSurfaceVariant,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: GoogleFonts.inter(
        color: onSurfaceVariant,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: GoogleFonts.inter(
        color: onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: GoogleFonts.inter(
        color: onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.inter(
        color: onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceContainerLowest,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: const IconThemeData(color: onSurface),
      titleTextStyle: GoogleFonts.manrope(
        color: onSurface,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceContainerLowest,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      labelStyle: const TextStyle(color: onSurfaceVariant),
    ),
  );

  static BoxDecoration get cardDecoration => BoxDecoration(
    color: surfaceContainerLowest,
    borderRadius: BorderRadius.circular(8),
  );

  static List<BoxShadow> get ambientShadow => [
    BoxShadow(blurRadius: 32, spreadRadius: 0, color: onSurface.withAlpha(15)),
  ];

  static BoxDecoration get buttonGradientDecoration => BoxDecoration(
    gradient: const LinearGradient(
      colors: [primary, primaryContainer],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(50),
  );
}
