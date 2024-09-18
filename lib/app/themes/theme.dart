import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeApp {
  static Color primaryColor = const Color.fromARGB(255, 46, 51, 55);
  static Color secondaryColor = const Color(0xFFffedd5);
  static Color accentColor = const Color(0xFF7dd3fc);
  static Color neutralColor = const Color(0xFF362037);
  static Color infoColor = const Color(0xFFc7d2fe);
  static Color errorColor = const Color(0xFFF43E56);
  static Color warningColor = const Color(0xFFF6B02C);
  static Color successColor = const Color(0xFF0D7766);
  static Color backgroundColor = const Color(0xFFf5f5f4);
  // static Color secondaryColor = Color.fromRGBO(16, 85, 81, 1);
  static Color darkColor = const Color.fromARGB(255, 54, 54, 54);
  static Color dangerColor = const Color.fromARGB(255, 255, 91, 91);
  static Color grayColor = const Color.fromARGB(255, 239, 239, 255);
  static Color lightColor = const Color.fromARGB(255, 240, 240, 240);
  static Color grayTextColor = const Color.fromARGB(255, 168, 168, 168);
  static Color primaryTextColor = const Color.fromARGB(255, 50, 50, 50);
  static Color secondaryTextColor = const Color.fromARGB(255, 112, 136, 254);
  static Color darkTextColor = const Color.fromARGB(255, 55, 55, 55);
  static Color lightTextColor = const Color.fromARGB(255, 240, 240, 240);
  static Color accentTextColor = const Color.fromARGB(255, 255, 237, 149);
  static Color errorTextColor = const Color.fromARGB(255, 255, 149, 149);
  static Color successTextColor = const Color.fromARGB(255, 149, 255, 161);
  static Color warningTextColor = const Color.fromARGB(255, 255, 220, 149);

  static ThemeData defaultTheme = ThemeData(
    primaryColor: primaryColor,
    primaryColorDark: neutralColor,
    primaryColorLight: backgroundColor,
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: GoogleFonts.inter().fontFamily,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: primaryTextColor,
        fontSize: 96,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      ),
      displayMedium: TextStyle(
        color: primaryTextColor,
        fontSize: 60,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      displaySmall: TextStyle(
        color: primaryTextColor,
        fontSize: 48,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        color: primaryTextColor,
        fontSize: 34,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      headlineSmall: TextStyle(
        color: primaryTextColor,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        color: primaryTextColor,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleMedium: TextStyle(
        color: primaryTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        color: primaryTextColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyLarge: TextStyle(
        color: primaryTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        color: primaryTextColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      labelLarge: TextStyle(
        color: primaryTextColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.25,
      ),
      labelMedium: TextStyle(
        color: primaryTextColor,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      bodySmall: TextStyle(
        color: primaryTextColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      labelSmall: TextStyle(
        color: primaryTextColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: grayColor,
        ),
      ),
      hintStyle: TextStyle(
        color: grayTextColor,
        fontSize: 12,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: grayColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: darkColor.withOpacity(0.5),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: errorColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: errorColor,
        ),
      ),
      labelStyle: TextStyle(
          color: darkColor, fontSize: 14, fontWeight: FontWeight.w500),
      errorStyle: TextStyle(
        color: errorColor,
      ),
      suffixIconColor: primaryColor,
      suffixStyle: TextStyle(
        color: primaryColor,
      ),
      prefixIconColor: primaryColor,
      prefixStyle: TextStyle(
        color: primaryColor,
      ),
      contentPadding: const EdgeInsets.all(10),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: primaryColor,
        iconSize: 20,
        minimumSize: const Size(10, 10),
        padding: const EdgeInsets.all(5),
        shape: const CircleBorder(),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: lightTextColor,
        elevation: 0,
        backgroundColor: primaryColor,
        minimumSize: const Size(64, 28),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
    ),
    appBarTheme: AppBarTheme(
      color: primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: lightTextColor,
      ),
      toolbarTextStyle: TextTheme(
        titleLarge: TextStyle(
          color: lightTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ).bodyMedium,
      titleTextStyle: TextTheme(
        titleLarge: TextStyle(
          color: lightTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ).titleLarge,
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: accentColor)
        .copyWith(background: lightColor)
        .copyWith(error: errorColor),
  );
}
