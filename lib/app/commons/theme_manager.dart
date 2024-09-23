import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeManager {
  Color primaryColor = const Color.fromARGB(255, 255, 188, 33);
  Color secondaryColor = const Color.fromARGB(255, 137, 206, 255);
  Color tertiaryColor = const Color.fromARGB(255, 255, 116, 116);
  Color backgroundColor = const Color(0xFFF8F8F8);
  Color textColor = const Color(0xFF0C1C2C);
  Color blackColor = const Color(0xFF0C1C2C);
  Color accentColor = const Color.fromARGB(255, 68, 255, 243);
  Color hintColor = const Color(0xFF6C757D);
  Color errorColor = const Color(0xFFFF4443);
  Color successColor = const Color(0xff24C38E);
  Color warningColor = const Color(0xFFF38B01);
  Color infoColor = const Color(0xFF03A9F4);

  Color shadowColor = Colors.grey[300]!;
  Color borderColor = Colors.grey[300]!;
  Color scaffoldBackgroundColor = const Color(0xFFF8F8F8);
  Color appBarBackgroundColor = Colors.white;

  ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: blackColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: primaryColor,
        unselectedLabelColor: textColor,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        ),
        indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: primaryColor,
          )),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appBarBackgroundColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: textColor,
        ),
        actionsIconTheme: IconThemeData(
          color: textColor,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: appBarBackgroundColor,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        scrolledUnderElevation: 0,
      ),
      shadowColor: blackColor,
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: primaryColor,
        textColor: textColor,
      ),
      fontFamily: 'Inter',
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: textColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: textColor,
          fontSize: 14,
        ),
        bodyMedium: TextStyle(
          color: textColor,
          fontSize: 12,
        ),
        bodySmall: TextStyle(
          color: textColor,
          fontSize: 10,
        ),
        titleMedium: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        labelLarge: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        labelMedium: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        labelSmall: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey.shade400),
        labelStyle: TextStyle(color: textColor, fontSize: 14),
        errorStyle: TextStyle(color: errorColor),
        counterStyle: TextStyle(color: hintColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: blackColor,
            width: 3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: blackColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor),
        ),
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        fillColor: Colors.white,
        constraints: const BoxConstraints(minHeight: 40),
        isDense: true,
        suffixIconColor: blackColor,
        prefixIconColor: blackColor,
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.all(blackColor),
          fixedSize: WidgetStateProperty.all(const Size(30, 30)),
          padding: WidgetStateProperty.all(const EdgeInsets.all(5)),
          iconSize: WidgetStateProperty.all(20),
          minimumSize: WidgetStateProperty.all(const Size(10, 10)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              //   side: BorderSide(color: , width: 1),
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(blackColor),
          padding: WidgetStateProperty.all(
            const EdgeInsets.all(10),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: primaryColor, width: 0),
            ),
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: blackColor,
        unselectedLabelStyle: const TextStyle(
          color: Color(0xFF002033),
          fontSize: 10,
          fontWeight: FontWeight.w300,
        ),
        selectedLabelStyle: TextStyle(
          color: blackColor,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        unselectedItemColor: hintColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(primaryColor),
          foregroundColor: WidgetStateProperty.all(textColor),
          fixedSize: WidgetStateProperty.all(
            const Size(double.infinity, 40),
          ),
          shadowColor: WidgetStateProperty.all(blackColor),
          padding: WidgetStateProperty.all(
            const EdgeInsets.all(0),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: primaryColor, width: 0),
            ),
          ),
        ),
      ),
      //   colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),
    );
  }

  BoxShadow defaultShadow() {
    return BoxShadow(
      color: ThemeManager().blackColor,
      blurRadius: 0,
      spreadRadius: 1,
      offset: const Offset(3, 3),
      blurStyle: BlurStyle.normal,
    );
  }
}
