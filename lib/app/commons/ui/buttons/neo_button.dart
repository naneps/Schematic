import 'package:flutter/material.dart';
import 'package:schematic/app/commons/theme_manager.dart';

class NeoButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Function? onHover;
  final FocusNode? focusNode;
  final bool? autofocus;
  final IconAlignment? iconAlignment;
  final ValueChanged<bool>? onFocusChange;
  final Clip? clipBehavior;
  final Widget child;

  final ButtonStyle? style;
  const NeoButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.onLongPress,
    this.onHover,
    this.focusNode,
    this.autofocus,
    this.iconAlignment,
    this.onFocusChange,
    this.style,
    this.clipBehavior,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: ThemeManager().defaultBorder(),
      ),
      clipBehavior: Clip.hardEdge,
      child: ElevatedButton(
        style: style,
        onPressed: onPressed,
        onLongPress: onLongPress,
        onHover: (value) {
          if (onHover != null) {
            onHover!(value);
          }
        },
        focusNode: focusNode,
        autofocus: autofocus ?? false,
        key: key,
        iconAlignment: iconAlignment ?? IconAlignment.end,
        onFocusChange: onFocusChange,
        // statesController: statesController,
        child: child,
      ),
    );
  }

  static icon({
    required VoidCallback? onPressed,
    required Widget icon,
    IconAlignment? iconAlignment,
    Clip? clipBehavior,
    Widget? label,
    ButtonStyle? style,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: ThemeManager().defaultBorder(),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        clipBehavior: clipBehavior,
        style: style,
        icon: icon,
        iconAlignment: IconAlignment.end,
        label: label ?? const SizedBox(),
      ),
    );
  }
}
