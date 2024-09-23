import 'package:flutter/material.dart';

enum ScreenSize { Mobile, Tablet, Desktop }

class Responsive {
  static late BuildContext _context;

  // Initialize the Responsive class with the BuildContext
  static void init(BuildContext context) {
    _context = context;
  }

  // Get the screen width
  static double width() => MediaQuery.of(_context).size.width;

  // Get the screen height
  static double height() => MediaQuery.of(_context).size.height;

  // Determine the screen size category
  static ScreenSize get screenSize {
    double width = Responsive.width();
    if (width >= 1024) {
      return ScreenSize.Desktop;
    } else if (width >= 600) {
      return ScreenSize.Tablet;
    } else {
      return ScreenSize.Mobile;
    }
  }

  // Check if the device is Desktop
  static bool isDesktop() => screenSize == ScreenSize.Desktop;

  // Check if the device is Tablet
  static bool isTablet() => screenSize == ScreenSize.Tablet;

  // Check if the device is Mobile
  static bool isMobile() => screenSize == ScreenSize.Mobile;

  // Get the proportionate height as per screen size
  static double getProportionateScreenHeight(double inputHeight) {
    double screenHeight = height();
    // 812 is the layout height that designer use
    return (inputHeight / 812.0) * screenHeight;
  }

  // Get the proportionate width as per screen size
  static double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = width();
    // 375 is the layout width that designer use
    return (inputWidth / 375.0) * screenWidth;
  }
}
