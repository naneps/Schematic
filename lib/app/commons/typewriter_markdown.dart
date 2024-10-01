import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/code_preview.dart';

class TypewriterMarkdown extends StatefulWidget {
  final String text;
  const TypewriterMarkdown(this.text, {super.key});

  @override
  _TypewriterMarkdownState createState() => _TypewriterMarkdownState();
}

class _TypewriterMarkdownState extends State<TypewriterMarkdown>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _charCount;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _charCount,
      builder: (context, child) {
        String text = widget.text.substring(0, _charCount.value);
        return MarkdownWidget(
          data: text,
          tocController: TocController(),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          markdownGenerator: MarkdownGenerator(),
          config: MarkdownConfig(
            configs: [
              const CodeConfig(
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.white,
                ),
              ),
              PreConfig(
                textStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: 'monospace',
                ),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(
                    color: ThemeManager().blackColor,
                    width: 2,
                  ),
                  boxShadow: [
                    ThemeManager().defaultShadow(),
                  ],
                  borderRadius: BorderRadius.circular(5),
                ),
                wrapper: (child, code, language) {
                  return CodeWrapperWidget(child, code, language);
                },
              ),
              CodeConfig(
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  backgroundColor: ThemeManager().blackColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant TypewriterMarkdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _controller.dispose();
      _controller = AnimationController(
        duration: Duration(milliseconds: widget.text.length * 2),
        vsync: this,
      );
      _charCount =
          StepTween(begin: 0, end: widget.text.length).animate(_controller);
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.text.length * 2),
      vsync: this,
    );
    _charCount =
        StepTween(begin: 0, end: widget.text.length).animate(_controller);
    _controller.forward();
  }
}
