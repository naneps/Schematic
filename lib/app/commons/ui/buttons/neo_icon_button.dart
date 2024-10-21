import 'package:flutter/material.dart';
import 'package:schematic/app/commons/theme_manager.dart';

class NeoIconButton extends StatelessWidget {
  final Widget icon;
  final void Function()? onPressed;
  final ButtonStyle? style;
  final Color? color;
  final Size? size;
  const NeoIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.style,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size?.width,
      height: size?.height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: ThemeManager().defaultBorder(),
      ),
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      child: IconButton(
        style: style ??
            ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.zero,
              foregroundColor: color ?? ThemeManager().blackColor,
              shape: const CircleBorder(),
            ),
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
