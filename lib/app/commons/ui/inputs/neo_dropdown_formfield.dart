import 'package:flutter/material.dart';
import 'package:schematic/app/commons/theme_manager.dart';

class NeoDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final void Function(T?)? onChanged;
  final T? value;
  final Widget? hint;
  final bool? isDense;
  final InputDecoration? decoration;
  final TextStyle? style;
  const NeoDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.isDense = false,
    this.style,
    this.hint,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          ThemeManager().defaultShadow(),
        ],
      ),
      child: DropdownButtonFormField(
        items: items,
        hint: hint,
        value: value,
        menuMaxHeight: 200,
        isDense: isDense!,
        style: style,
        decoration: decoration,
        onChanged: (value) => onChanged!(value as T),
      ),
    );
  }
}
