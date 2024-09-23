// lib/app/utils/responsive_extensions.dart

import 'package:flutter/material.dart';

enum ScreenType { Mobile, Tablet, Desktop }

extension ResponsiveExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  Orientation get orientation => MediaQuery.of(this).orientation;

  ScreenType get screenType {
    if (screenWidth >= 1024) {
      return ScreenType.Desktop;
    } else if (screenWidth >= 600) {
      return ScreenType.Tablet;
    } else {
      return ScreenType.Mobile;
    }
  }

  double getProportionateScreenHeight(double inputHeight) {
    return (inputHeight / 812.0) * screenHeight;
  }

  double getProportionateScreenWidth(double inputWidth) {
    return (inputWidth / 375.0) * screenWidth;
  }

  // Responsive padding
  EdgeInsets responsivePadding({
    double vertical = 0,
    double horizontal = 0,
  }) {
    return EdgeInsets.symmetric(
      vertical: getProportionateScreenHeight(vertical),
      horizontal: getProportionateScreenWidth(horizontal),
    );
  }

  // Responsive font size
  double getResponsiveFontSize(double fontSize) {
    return getProportionateScreenWidth(fontSize);
  }

  // Responsive icon size
  double getResponsiveIconSize(double iconSize) {
    return getProportionateScreenWidth(iconSize);
  }
}
