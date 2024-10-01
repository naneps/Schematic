import 'package:flutter/material.dart';
import 'package:schematic/app/commons/theme_manager.dart';

class NeoIconButton extends StatelessWidget {
  final Widget icon;
  final void Function()? onPressed;
  final ButtonStyle? style;
  final Color? color;
  const NeoIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.style,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          ThemeManager().defaultShadow(),
        ],
        shape: BoxShape.circle,
      ),
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
