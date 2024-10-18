import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schematic/app/commons/theme_manager.dart';

class XInput extends StatefulWidget {
  final String? label;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSaved;
  final void Function()? onTap;
  final bool? hasCounter;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;
  final bool obscureText;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? hintText;
  final int? minLines;

  const XInput({
    super.key,
    this.label,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.floatingLabelBehavior,
    this.hasCounter = false,
    this.maxLength,
    this.onSaved,
    this.controller,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.readOnly = false,
    this.keyboardType,
    this.prefixIcon,
    this.hintText,
    this.onTap,
    this.inputFormatters,
    this.suffixIcon,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
  });

  @override
  State<XInput> createState() => _XInputState();
}

class _XInputState extends State<XInput> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [ThemeManager().defaultShadow()],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        key: _formKey,
        controller: _controller,
        focusNode: _focusNode,
        onTap: widget.onTap,
        validator: widget.validator,
        obscureText: widget.obscureText,
        readOnly: widget.readOnly ?? false,
        onSaved: (newValue) => widget.onSaved?.call(newValue ?? ''),
        onChanged: (value) {
          widget.onChanged?.call(value);
          _formKey.currentState?.validate();
        },
        maxLength: widget.hasCounter == true ? widget.maxLength : null,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        keyboardType: widget.keyboardType,
        cursorColor: ThemeManager().primaryColor,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          labelText: widget.label,
          contentPadding: widget.contentPadding,
          hintText: widget.hintText ??
              'Enter your ${widget.label?.toLowerCase() ?? ''}',
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          floatingLabelBehavior:
              widget.floatingLabelBehavior ?? FloatingLabelBehavior.auto,
          counter: widget.hasCounter == true
              ? buildCounter(
                  context: context,
                  maxLength: widget.maxLength ?? 0,
                  currentLength: _controller.text.length,
                  isFocused: _focusNode.hasFocus,
                  hasError: _formKey.currentState?.hasError ?? false,
                )
              : null,
        ),
      ),
    );
  }

  Widget buildCounter({
    required BuildContext context,
    required int maxLength,
    required int currentLength,
    required bool isFocused,
    required bool hasError,
  }) {
    return Text(
      '$currentLength/$maxLength',
      style: TextStyle(
        color: hasError
            ? Theme.of(context).colorScheme.error
            : isFocused
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).hintColor,
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_updateState);
    _focusNode.removeListener(_updateState);
    if (widget.controller == null) {
      // Dispose only if the controller was created locally
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Use the provided controller or create a new one if not provided
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _controller.addListener(_updateState);
    _focusNode.addListener(_updateState);
  }

  void _updateState() {
    setState(() {}); // Rebuild the widget on changes
  }
}
