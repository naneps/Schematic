// lib/app/utils/responsive_extensions.dart

import 'package:flutter/material.dart';

enum ScreenType { Mobile, Tablet, Desktop }

extension ResponsiveExtensions on BuildContext {
  Orientation get orientation => MediaQuery.of(this).orientation;

  double get screenHeight => MediaQuery.of(this).size.height;

  ScreenType get screenType {
    if (screenWidth < 600) {
      return ScreenType.Mobile;
    } else if (screenWidth < 1200) {
      return ScreenType.Tablet;
    } else {
      return ScreenType.Desktop;
    }
  }

  double get screenWidth => MediaQuery.of(this).size.width;

  double getProportionateScreenHeight(double inputHeight) {
    return (inputHeight / 812.0) * screenHeight;
  }

  double getProportionateScreenWidth(double inputWidth) {
    return (inputWidth / 375.0) * screenWidth;
  }

  double getResponsiveFontSize(double fontSize) {
    return getProportionateScreenWidth(fontSize);
  }

  double getResponsiveIconSize(double iconSize) {
    return getProportionateScreenWidth(iconSize);
  }

  EdgeInsets responsivePadding({double vertical = 0, double horizontal = 0}) {
    return EdgeInsets.symmetric(
      vertical: getProportionateScreenHeight(vertical),
      horizontal: getProportionateScreenWidth(horizontal),
    );
  }
}
