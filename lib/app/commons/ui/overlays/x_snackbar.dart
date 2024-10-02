import 'package:flutter/material.dart';
import 'package:schematic/app/commons/theme_manager.dart';

enum SnackBarType {
  success,
  error,
  warning,
  info,
}

class XSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.info,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: ThemeManager().scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: type.backgroundColor),
              boxShadow: [
                ThemeManager().defaultShadow(
                  color: type.backgroundColor,
                ),
              ]),
          child: Row(
            children: [
              Text(
                message,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          left: 20,
          right: 20,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,

        // action: SnackBarAction(
        //   label: 'Close',
        //   textColor: type.textColor,
        //   onPressed: () {
        //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
        //   },
        // ),
        hitTestBehavior: HitTestBehavior.opaque,
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}

extension SnackBarTypeExtension on SnackBarType {
  Color get backgroundColor {
    switch (this) {
      case SnackBarType.success:
        return ThemeManager().successColor;
      case SnackBarType.error:
        return ThemeManager().errorColor;
      case SnackBarType.warning:
        return ThemeManager().warningColor;
      case SnackBarType.info:
        return ThemeManager().infoColor;
    }
  }

  Color get color {
    switch (this) {
      case SnackBarType.success:
        return ThemeManager().successColor;
      case SnackBarType.error:
        return ThemeManager().errorColor;
      case SnackBarType.warning:
        return ThemeManager().warningColor;
      case SnackBarType.info:
        return ThemeManager().infoColor;
    }
  }

  Color get textColor {
    switch (this) {
      case SnackBarType.success:
        return Colors.white;
      case SnackBarType.error:
        return Colors.white;
      case SnackBarType.warning:
        return ThemeManager().textColor;
      case SnackBarType.info:
        return ThemeManager().textColor;
    }
  }
}
