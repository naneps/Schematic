import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
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
          markdownGenerator: MarkdownGenerator(),
          config: MarkdownConfig(
            configs: [
              const BlockquoteConfig(),
              const HrConfig(),
              const CodeConfig(
                style: TextStyle(
                  fontFamily: 'monospace',
                ),
              ),
              PreConfig(
                // Styles for preformatted (code) blocks
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'monospace',
                ),

                theme: {
                  'pre': TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                  ),
                  'json': const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    color: Colors.green, // Custom color for JSON blocks
                  ),
                  'quote':
                      const TextStyle(color: Color.fromARGB(255, 6, 27, 255)),
                  'code':
                      const TextStyle(color: Color.fromARGB(255, 6, 27, 255)),
                  'h1': const TextStyle(color: Colors.red),
                },
                wrapper: (child, code, language) {
                  if (language == 'json') {
                    return CodeWrapperWidget(child, code, language);
                  }
                  return CodeWrapperWidget(child, code, language);
                },
              ),
              const PConfig(),
              const HrConfig(),
              const TableConfig(),
              const CodeConfig(
                style: TextStyle(
                  fontFamily: 'monospace',
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
        duration: Duration(milliseconds: widget.text.length * 5),
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
      duration: Duration(milliseconds: widget.text.length * 5),
      vsync: this,
    );
    _charCount =
        StepTween(begin: 0, end: widget.text.length).animate(_controller);
    _controller.forward();
  }
}
