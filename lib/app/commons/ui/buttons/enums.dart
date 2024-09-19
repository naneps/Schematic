import 'package:flutter/material.dart';
import 'package:schematic/app/commons/theme_manager.dart';

enum TypeButton { primary, secondary, tertiary, danger, warning, success, none }

extension TypeButtonExtension on TypeButton {
  Color get color {
    switch (this) {
      case TypeButton.primary:
        return ThemeManager().primaryColor;
      case TypeButton.secondary:
        return ThemeManager().secondaryColor;
      case TypeButton.tertiary:
        return ThemeManager().tertiaryColor;
      case TypeButton.danger:
        return ThemeManager().errorColor;
      case TypeButton.warning:
        return ThemeManager().warningColor;
      case TypeButton.success:
        return ThemeManager().successColor;
      case TypeButton.none:
        return Colors.transparent;
    }
  }
}
