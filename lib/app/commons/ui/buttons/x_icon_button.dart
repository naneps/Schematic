import 'package:flutter/material.dart';

class XIconButton extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;
  final Color? color;
  final double? size;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double? elevation;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? borderColor;
  final double? borderWidth;

  const XIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.size,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.iconSize,
    this.backgroundColor,
    this.shadowColor,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      elevation: elevation ?? 0,
      shadowColor: shadowColor ?? Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        child: Container(
          width: size ?? 48.0, // Default size if not provided
          height: size ?? 48.0, // Default size if not provided
          padding: padding ?? const EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth ?? 0,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
          ),
          child: Icon(
            icon,
            color: color,
            size: iconSize,
          ),
        ),
      ),
    );
  }

  static XIconButton filled({
    Key? key,
    required IconData icon,
    Function()? onPressed,
    Color? color,
    double? size,
    EdgeInsets? padding,
    double? borderRadius,
    double? elevation,
    Color? backgroundColor,
    double? iconSize,
  }) {
    return XIconButton(
      key: key,
      icon: icon,
      onPressed: onPressed,
      color: color ?? Colors.white,
      size: size ?? 48.0, // Default size for filled button
      padding: padding,
      borderRadius: borderRadius ?? 4.0,
      elevation: elevation ?? 4.0,
      iconSize: iconSize ?? 24.0,
      backgroundColor: backgroundColor ?? Colors.blue,
      shadowColor: Colors.black.withOpacity(0.2),
    );
  }

  static XIconButton outline({
    Key? key,
    required IconData icon,
    Function()? onPressed,
    Color? color,
    double? size,
    EdgeInsets? padding,
    double? borderRadius,
    double? borderWidth,
    Color? borderColor,
    double? iconSize,
  }) {
    return XIconButton(
      key: key,
      icon: icon,
      onPressed: onPressed,
      size: size ?? 48.0, // Default size for outline button
      padding: padding,
      color: color ?? Colors.black,
      borderRadius: borderRadius ?? 4.0,
      borderWidth: borderWidth ?? 1.0,
      borderColor: borderColor ?? Colors.black,
      iconSize: iconSize ?? 24.0,
      backgroundColor: Colors.transparent,
    );
  }
}
