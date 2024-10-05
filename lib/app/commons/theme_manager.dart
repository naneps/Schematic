import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeManager {
  Color primaryColor = const Color.fromARGB(255, 253, 75, 134);
  Color secondaryColor = const Color.fromARGB(255, 48, 199, 233);
  Color tertiaryColor = const Color.fromARGB(255, 255, 116, 116);
  Color backgroundColor = const Color(0xFFF8F8F8);
  Color textColor = const Color.fromARGB(255, 28, 28, 33);
  Color blackColor = const Color(0xFF0C1C2C);
  Color accentColor = const Color.fromARGB(255, 68, 255, 243);
  Color hintColor = const Color(0xFF6C757D);
  Color errorColor = const Color.fromARGB(255, 234, 73, 73);
  Color successColor = const Color(0xff24C38E);
  Color warningColor = const Color(0xFFF38B01);
  Color infoColor = const Color.fromARGB(255, 48, 199, 233);
  Color shadowColor = Colors.grey[300]!;
  Color borderColor = Colors.grey[300]!;
  Color scaffoldBackgroundColor = const Color.fromARGB(255, 255, 250, 241);
  Color appBarBackgroundColor = Colors.white;

  ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      canvasColor: scaffoldBackgroundColor,

      visualDensity: VisualDensity.compact,
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
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
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
        backgroundColor: scaffoldBackgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        centerTitle: true,
        toolbarTextStyle: TextStyle(
          color: textColor,
        ),
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

      drawerTheme: const DrawerThemeData(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      shadowColor: blackColor,
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: primaryColor,
        textColor: textColor,
      ),
      fontFamily: 'monospace',
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace',
        ),
        displayMedium: TextStyle(
          color: textColor,
          fontSize: 22,
          fontFamily: 'monospace',
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: textColor,
          fontSize: 20,
          fontFamily: 'monospace',
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: textColor,
          fontFamily: 'monospace',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: textColor,
          fontFamily: 'monospace',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          fontFamily: 'monospace',
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: textColor,
          fontFamily: 'monospace',
          fontSize: 14,
        ),
        bodyMedium: TextStyle(
          color: textColor,
          fontFamily: 'monospace',
          fontSize: 12,
        ),
        bodySmall: TextStyle(
          fontFamily: 'monospace',
          color: textColor,
          fontSize: 10,
        ),
        titleMedium: TextStyle(
          fontFamily: 'monospace',
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(
          color: textColor,
          fontFamily: 'monospace',
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        labelLarge: TextStyle(
          fontFamily: 'monospace',
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        labelMedium: TextStyle(
          color: textColor,
          fontFamily: 'monospace',
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        labelSmall: TextStyle(
          color: textColor,
          fontFamily: 'monospace',
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12),
        labelStyle: TextStyle(color: textColor, fontSize: 12),
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
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        filled: true,
        fillColor: scaffoldBackgroundColor,
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
          backgroundColor: WidgetStateProperty.all(Colors.white),
          foregroundColor: WidgetStateProperty.all(blackColor),
          fixedSize: WidgetStateProperty.all(const Size(30, 30)),
          padding: WidgetStateProperty.all(const EdgeInsets.all(5)),
          iconSize: WidgetStateProperty.all(20),
          minimumSize: WidgetStateProperty.all(const Size(10, 10)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              // side: BorderSide(color: , width: 1),
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
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: blackColor,
          minimumSize: const Size(100, 40),
          shadowColor: blackColor,
          elevation: 0,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          visualDensity: VisualDensity.compact,
          disabledBackgroundColor: Colors.grey.shade200,
          disabledForegroundColor: Colors.grey.shade400,
          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      //   colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),
    );
  }

  BoxShadow defaultShadow({Color? color}) {
    return BoxShadow(
      color: color ?? ThemeManager().blackColor,
      blurRadius: 0,
      spreadRadius: 1,
      offset: const Offset(2, 3),
      blurStyle: BlurStyle.solid,
    );
  }
}
