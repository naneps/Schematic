import 'package:flutter/material.dart';
import 'package:schematic/app/commons/theme_manager.dart';

class NeoButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final ButtonStyle? style;
  const NeoButton({super.key, required this.child, this.onPressed, this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          ThemeManager().defaultShadow(),
        ],
        border: Border.all(color: ThemeManager().blackColor, width: 2),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ElevatedButton(
        style: style ??
            ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }

  static NeoButton icon({
    Key? key,
    required Icon icon,
    Function()? onPressed,
    ButtonStyle? style,
    Widget? label,
  }) {
    return NeoButton(
      key: key,
      onPressed: onPressed,
      style: style,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          if (label != null) ...[const SizedBox(width: 10), label],
        ],
      ),
    );
  }
}
