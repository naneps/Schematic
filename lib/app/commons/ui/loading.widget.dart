import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:schematic/app/commons/theme_manager.dart';

class LoadingWidget extends StatelessWidget {
  final List<String>? text;
  const LoadingWidget({
    super.key,
    this.text = const ["Loading...", "Please wait..."],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LoadingAnimationWidget.dotsTriangle(
          size: 40,
          color: ThemeManager().primaryColor,
        ),
        const SizedBox(height: 10),
        AnimatedTextKit(
          animatedTexts: [
            ...text!.map(
              (t) => TypewriterAnimatedText(
                t,
                textAlign: TextAlign.center,
                textStyle: Get.textTheme.labelMedium!.copyWith(
                  color: ThemeManager().blackColor,
                ),
                speed: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              ),
            )
          ],
          repeatForever: true,
        )
      ],
    );
  }
}
