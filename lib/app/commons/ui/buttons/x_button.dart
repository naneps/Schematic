import 'package:flutter/material.dart';
import 'package:get/get.dart';

class XButton extends StatelessWidget {
  final Widget? child;
  final String? text;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Size? fixedSize;
  final EdgeInsets padding;
  final double? borderRadius;
  final TextStyle? textStyle;
  final BorderSide? borderSide;
  final void Function()? onPressed;
  const XButton({
    super.key,
    this.child,
    this.text,
    required this.onPressed,
    this.foregroundColor,
    this.fixedSize,
    this.borderSide,
    this.backgroundColor,
    this.borderRadius,
    this.padding = const EdgeInsets.all(10),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    assert((child == null) != (text == null),
        'You must provide either a child or a text, but not both.');

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        fixedSize: fixedSize ?? Size(Get.width, 40),
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
          side: borderSide ?? BorderSide.none,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      child: child ??
          Text(
            text ?? '',
            style: textStyle,
          ),
    );
  }

  static XButton outline({
    required String text,
    required void Function() onPressed,
    Color? foregroundColor,
    Color? backgroundColor = Colors.transparent,
    Size? fixedSize,
    EdgeInsets padding = const EdgeInsets.all(10),
    double? borderRadius,
    TextStyle? textStyle,
    BorderSide borderSide = const BorderSide(color: Colors.black, width: 1),
  }) {
    return XButton(
      text: text,
      onPressed: onPressed,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      fixedSize: fixedSize,
      padding: padding,
      borderRadius: borderRadius,
      textStyle: textStyle,
      borderSide: borderSide,
    );
  }
}
