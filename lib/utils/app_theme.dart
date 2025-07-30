import 'package:flutter/material.dart';

class AppTheme {
  // shadcn/ui inspired color system with WCAG 2.1 AA compliance

  // Base colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Light theme colors
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightForeground = Color(0xFF0F172A); // slate-900
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardForeground = Color(0xFF0F172A);
  static const Color lightPopover = Color(0xFFFFFFFF);
  static const Color lightPopoverForeground = Color(0xFF0F172A);
  static const Color lightPrimary = Color(0xFF0F172A); // slate-900
  static const Color lightPrimaryForeground = Color(0xFFF8FAFC); // slate-50
  static const Color lightSecondary = Color(0xFFF1F5F9); // slate-100
  static const Color lightSecondaryForeground = Color(0xFF0F172A);
  static const Color lightMuted = Color(0xFFF1F5F9); // slate-100
  static const Color lightMutedForeground = Color(0xFF64748B); // slate-500
  static const Color lightAccent = Color(0xFFF1F5F9);
  static const Color lightAccentForeground = Color(0xFF0F172A);
  static const Color lightDestructive = Color(0xFFEF4444); // red-500
  static const Color lightDestructiveForeground = Color(0xFFF8FAFC);
  static const Color lightBorder = Color(0xFFE2E8F0); // slate-200
  static const Color lightInput = Color(0xFFE2E8F0);
  static const Color lightRing = Color(0xFF0F172A);

  // Dark theme colors
  static const Color darkBackground = Color(0xFF020617); // slate-950
  static const Color darkForeground = Color(0xFFF8FAFC); // slate-50
  static const Color darkCard = Color(0xFF020617);
  static const Color darkCardForeground = Color(0xFFF8FAFC);
  static const Color darkPopover = Color(0xFF020617);
  static const Color darkPopoverForeground = Color(0xFFF8FAFC);
  static const Color darkPrimary = Color(0xFFF8FAFC);
  static const Color darkPrimaryForeground = Color(0xFF0F172A);
  static const Color darkSecondary = Color(0xFF1E293B); // slate-800
  static const Color darkSecondaryForeground = Color(0xFFF8FAFC);
  static const Color darkMuted = Color(0xFF1E293B);
  static const Color darkMutedForeground = Color(0xFF94A3B8); // slate-400
  static const Color darkAccent = Color(0xFF1E293B);
  static const Color darkAccentForeground = Color(0xFFF8FAFC);
  static const Color darkDestructive = Color(0xFF7F1D1D); // red-900
  static const Color darkDestructiveForeground = Color(0xFFF8FAFC);
  static const Color darkBorder = Color(0xFF1E293B);
  static const Color darkInput = Color(0xFF1E293B);
  static const Color darkRing = Color(0xFF94A3B8);

  // Semantic colors (consistent across themes)
  static const Color healthColor = Color(0xFF10B981); // emerald-500
  static const Color healthColorLight = Color(0xFFD1FAE5); // emerald-100
  static const Color wealthColor = Color(0xFF3B82F6); // blue-500
  static const Color wealthColorLight = Color(0xFFDBEAFE); // blue-100
  static const Color warningColor = Color(0xFFF59E0B); // amber-500
  static const Color warningColorLight = Color(0xFFFEF3C7); // amber-100
  static const Color successColor = Color(0xFF10B981); // emerald-500
  static const Color successColorLight = Color(0xFFD1FAE5); // emerald-100
  static const Color errorColor = Color(0xFFEF4444); // red-500
  static const Color errorColorLight = Color(0xFFFEE2E2); // red-100
  static const Color infoColor = Color(0xFF3B82F6); // blue-500
  static const Color infoColorLight = Color(0xFFDBEAFE); // blue-100
  static const Color purpleColor = Color(0xFF8B5CF6); // violet-500

  // Legacy color support for backward compatibility
  static const Color primaryColor = lightPrimary;
  static const Color secondaryColor = lightSecondary;
  static const Color accentColor = lightAccent;
  static const Color backgroundColor = lightBackground;
  static const Color surfaceColor = lightCard;
  static const Color mutedColor = lightMuted;
  static const Color mutedForegroundColor = lightMutedForeground;
  static const Color destructiveColor = lightDestructive;

  // Typography scale
  static const double fontSizeXs = 12.0;
  static const double fontSizeSm = 14.0;
  static const double fontSizeBase = 16.0;
  static const double fontSizeLg = 18.0;
  static const double fontSizeXl = 20.0;
  static const double fontSize2xl = 24.0;
  static const double fontSize3xl = 30.0;
  static const double fontSize4xl = 36.0;

  // Spacing scale
  static const double spacing1 = 4.0;
  static const double spacing2 = 8.0;
  static const double spacing3 = 12.0;
  static const double spacing4 = 16.0;
  static const double spacing5 = 20.0;
  static const double spacing6 = 24.0;
  static const double spacing8 = 32.0;
  static const double spacing10 = 40.0;
  static const double spacing12 = 48.0;
  static const double spacing16 = 64.0;
  static const double spacing20 = 80.0;

  // Border radius
  static const double radiusSm = 6.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radius2xl = 24.0;
  static const double radiusFull = 9999.0;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Satoshi',
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: lightPrimary,
      onPrimary: lightPrimaryForeground,
      secondary: lightSecondary,
      onSecondary: lightSecondaryForeground,
      tertiary: lightAccent,
      onTertiary: lightAccentForeground,
      error: lightDestructive,
      onError: lightDestructiveForeground,
      surface: lightCard,
      onSurface: lightCardForeground,
      surfaceContainerHighest: lightMuted,
      onSurfaceVariant: lightMutedForeground,
      outline: lightBorder,
      outlineVariant: lightInput,
    ),
    scaffoldBackgroundColor: lightBackground,

    // App Bar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: lightBackground,
      foregroundColor: lightForeground,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Satoshi',
        color: lightForeground,
        fontSize: fontSize2xl,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.025,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: lightCard,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLg),
        side: const BorderSide(color: lightBorder, width: 1),
      ),
      margin: EdgeInsets.zero,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightPrimary,
        foregroundColor: lightPrimaryForeground,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: spacing4, vertical: spacing3),
        textStyle: const TextStyle(
          fontSize: fontSizeSm,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: lightForeground,
        backgroundColor: lightBackground,
        elevation: 0,
        shadowColor: Colors.transparent,
        side: const BorderSide(color: lightBorder, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: spacing4, vertical: spacing3),
        textStyle: const TextStyle(
          fontSize: fontSizeSm,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: lightPrimary,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: spacing4, vertical: spacing3),
        textStyle: const TextStyle(
          fontSize: fontSizeSm,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: const BorderSide(color: lightBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: const BorderSide(color: lightBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: const BorderSide(color: lightRing, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: const BorderSide(color: lightDestructive, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: const BorderSide(color: lightDestructive, width: 2),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: spacing3, vertical: spacing3),
      hintStyle: const TextStyle(
        color: lightMutedForeground,
        fontSize: fontSizeSm,
      ),
      labelStyle: const TextStyle(
        color: lightForeground,
        fontSize: fontSizeSm,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: lightCard,
      selectedItemColor: lightPrimary,
      unselectedItemColor: lightMutedForeground,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: TextStyle(
        fontSize: fontSizeXs,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: fontSizeXs,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Tab Bar Theme
    tabBarTheme: const TabBarThemeData(
      labelColor: lightPrimary,
      unselectedLabelColor: lightMutedForeground,
      indicatorColor: lightPrimary,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(
        fontSize: fontSizeSm,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: fontSizeSm,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: lightPrimary,
      linearTrackColor: lightMuted,
    ),

    // Text Theme
    textTheme: const TextTheme(
      // Display styles
      displayLarge: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSize4xl,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.025,
        color: lightForeground,
        height: 1.2,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSize3xl,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.025,
        color: lightForeground,
        height: 1.2,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSize2xl,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.025,
        color: lightForeground,
        height: 1.3,
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSize2xl,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.025,
        color: lightForeground,
        height: 1.3,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeXl,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.025,
        color: lightForeground,
        height: 1.3,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeLg,
        fontWeight: FontWeight.w600,
        color: lightForeground,
        height: 1.4,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeBase,
        fontWeight: FontWeight.w600,
        color: lightForeground,
        height: 1.5,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeSm,
        fontWeight: FontWeight.w600,
        color: lightForeground,
        height: 1.5,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeXs,
        fontWeight: FontWeight.w600,
        color: lightForeground,
        height: 1.5,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeBase,
        fontWeight: FontWeight.w400,
        color: lightForeground,
        height: 1.6,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeSm,
        fontWeight: FontWeight.w400,
        color: lightForeground,
        height: 1.6,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeXs,
        fontWeight: FontWeight.w400,
        color: lightMutedForeground,
        height: 1.5,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeSm,
        fontWeight: FontWeight.w500,
        color: lightForeground,
        height: 1.4,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeXs,
        fontWeight: FontWeight.w500,
        color: lightForeground,
        height: 1.4,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeXs,
        fontWeight: FontWeight.w500,
        color: lightMutedForeground,
        height: 1.4,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Satoshi',
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: darkPrimary,
      onPrimary: darkPrimaryForeground,
      secondary: darkSecondary,
      onSecondary: darkSecondaryForeground,
      tertiary: darkAccent,
      onTertiary: darkAccentForeground,
      error: darkDestructive,
      onError: darkDestructiveForeground,
      surface: darkCard,
      onSurface: darkCardForeground,
      surfaceContainerHighest: darkMuted,
      onSurfaceVariant: darkMutedForeground,
      outline: darkBorder,
      outlineVariant: darkInput,
    ),
    scaffoldBackgroundColor: darkBackground,

    // App Bar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: darkForeground,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Satoshi',
        color: darkForeground,
        fontSize: fontSize2xl,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.025,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: darkCard,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLg),
        side: const BorderSide(color: darkBorder, width: 1),
      ),
      margin: EdgeInsets.zero,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkPrimary,
        foregroundColor: darkPrimaryForeground,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: spacing4, vertical: spacing3),
        textStyle: const TextStyle(
          fontSize: fontSizeSm,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: darkForeground,
        backgroundColor: darkBackground,
        elevation: 0,
        shadowColor: Colors.transparent,
        side: const BorderSide(color: darkBorder, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: spacing4, vertical: spacing3),
        textStyle: const TextStyle(
          fontSize: fontSizeSm,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: darkPrimary,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: spacing4, vertical: spacing3),
        textStyle: const TextStyle(
          fontSize: fontSizeSm,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: const BorderSide(color: darkBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: const BorderSide(color: darkBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: const BorderSide(color: darkRing, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: const BorderSide(color: darkDestructive, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: const BorderSide(color: darkDestructive, width: 2),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: spacing3, vertical: spacing3),
      hintStyle: const TextStyle(
        color: darkMutedForeground,
        fontSize: fontSizeSm,
      ),
      labelStyle: const TextStyle(
        color: darkForeground,
        fontSize: fontSizeSm,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkCard,
      selectedItemColor: darkPrimary,
      unselectedItemColor: darkMutedForeground,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: TextStyle(
        fontSize: fontSizeXs,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: fontSizeXs,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Tab Bar Theme
    tabBarTheme: const TabBarThemeData(
      labelColor: darkPrimary,
      unselectedLabelColor: darkMutedForeground,
      indicatorColor: darkPrimary,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(
        fontSize: fontSizeSm,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: fontSizeSm,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: darkPrimary,
      linearTrackColor: darkMuted,
    ),

    // Text Theme
    textTheme: const TextTheme(
      // Display styles
      displayLarge: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSize4xl,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.025,
        color: darkForeground,
        height: 1.2,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSize3xl,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.025,
        color: darkForeground,
        height: 1.2,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSize2xl,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.025,
        color: darkForeground,
        height: 1.3,
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSize2xl,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.025,
        color: darkForeground,
        height: 1.3,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeXl,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.025,
        color: darkForeground,
        height: 1.3,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeLg,
        fontWeight: FontWeight.w600,
        color: darkForeground,
        height: 1.4,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeBase,
        fontWeight: FontWeight.w600,
        color: darkForeground,
        height: 1.5,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeSm,
        fontWeight: FontWeight.w600,
        color: darkForeground,
        height: 1.5,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeXs,
        fontWeight: FontWeight.w600,
        color: darkForeground,
        height: 1.5,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeBase,
        fontWeight: FontWeight.w400,
        color: darkForeground,
        height: 1.6,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeSm,
        fontWeight: FontWeight.w400,
        color: darkForeground,
        height: 1.6,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeXs,
        fontWeight: FontWeight.w400,
        color: darkMutedForeground,
        height: 1.5,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeSm,
        fontWeight: FontWeight.w500,
        color: darkForeground,
        height: 1.4,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeXs,
        fontWeight: FontWeight.w500,
        color: darkForeground,
        height: 1.4,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: fontSizeXs,
        fontWeight: FontWeight.w500,
        color: darkMutedForeground,
        height: 1.4,
      ),
    ),
  );
}
