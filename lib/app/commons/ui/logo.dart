import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';

class Logo extends StatelessWidget {
  final double? fontSize;
  const Logo({super.key, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: ThemeManager().scaffoldBackgroundColor,
        boxShadow: const [],
        border: ThemeManager().defaultBorder(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          text: "",
          style: Get.textTheme.displayLarge!,
          children: [
            TextSpan(
              text: 'Sche',
              style: Get.textTheme.labelLarge!.copyWith(
                color: ThemeManager().blackColor,
                height: 1.3,
                fontFamily: 'Poppins',
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
                fontSize: fontSize ?? 20,
              ),
            ),
            TextSpan(
              text: 'matic ',
              style: Get.textTheme.labelLarge!.copyWith(
                color: ThemeManager().blackColor,
                fontFamily: 'Poppins',
                fontSize: fontSize ?? 20,
                height: 1.3,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
