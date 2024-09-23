import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-0.29, -0.1),
          end: const Alignment(0.05, 0.02),
          colors: [
            ThemeManager().blackColor,
            ThemeManager().primaryColor,
          ],
          stops: const [0, 1],
          tileMode: TileMode.clamp,
        ),
        boxShadow: [ThemeManager().defaultShadow()],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          text: "",
          style: Get.textTheme.displayLarge!,
          children: [
            TextSpan(
              text: 'Sche',
              style: Get.textTheme.displayMedium!.copyWith(
                color: Colors.white,
                height: 1.3,
                letterSpacing: 1.5,
              ),
            ),
            TextSpan(
              text: 'matic ',
              style: Get.textTheme.displayMedium!.copyWith(
                color: ThemeManager().blackColor,
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
