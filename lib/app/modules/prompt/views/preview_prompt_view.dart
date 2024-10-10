import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/modules/core/controllers/core_controller.dart';

class PreviewPromptView extends StatelessWidget {
  final CoreController controller;

  const PreviewPromptView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Markdown(
        data: controller.prompt.value.toMarkdown(),
        selectable: true,
        builders: const {},
        styleSheet: MarkdownStyleSheet(
          code: const TextStyle(
            fontFamily: 'monospace',
            color: Colors.white,
            fontSize: 16,
            backgroundColor: Colors.transparent,
          ),
          codeblockDecoration: BoxDecoration(
            color: ThemeManager().blackColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: ThemeManager().blackColor,
              width: 2,
            ),
            boxShadow: [
              ThemeManager().defaultShadow(),
            ],
          ),
          blockquote: TextStyle(
            fontFamily: 'monospace',
            fontSize: 14,
            color: ThemeManager().blackColor,
            fontStyle: FontStyle.italic,
          ),
          h1: TextStyle(
            fontFamily: 'monospace',
            fontSize: 20,
            color: ThemeManager().blackColor,
          ),
          h2: TextStyle(
            fontFamily: 'monospace',
            fontSize: 18,
            color: ThemeManager().blackColor,
          ),
          h3: TextStyle(
            fontFamily: 'monospace',
            fontSize: 16,
            color: ThemeManager().blackColor,
          ),
          h4: TextStyle(
            fontFamily: 'monospace',
            fontSize: 14,
            color: ThemeManager().blackColor,
          ),
          h5: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: ThemeManager().blackColor,
          ),
          h6: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            color: ThemeManager().blackColor,
          ),
          p: TextStyle(
            fontFamily: 'monospace',
            fontSize: 16,
            color: ThemeManager().blackColor,
          ),
          strong: TextStyle(
            fontFamily: 'monospace',
            fontSize: 16,
            color: ThemeManager().blackColor,
          ),
          em: TextStyle(
            fontFamily: 'monospace',
            fontSize: 16,
            color: ThemeManager().blackColor,
          ),
          tableBody: TextStyle(
            fontFamily: 'monospace',
            fontSize: 16,
            color: ThemeManager().blackColor,
          ),
        ),
      );
    });
  }
}
