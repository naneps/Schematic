import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/modules/prompt/controllers/prompt_controller.dart';

class PreviewPromptView extends StatelessWidget {
  final PromptController controller;

  const PreviewPromptView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 40,
                child: NeoButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeManager().infoColor,
                  ),
                  onPressed: () {},
                  child: const Text("Make Model"),
                ),
              ),
            ],
          ),
          Expanded(
            child: Obx(
              () {
                return Markdown(
                  data: controller.prompt.value.toMarkdown(),
                  selectable: true,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  builders: const {},
                  styleSheet: MarkdownStyleSheet(
                    code: TextStyle(
                      fontFamily: 'monospace',
                      color: ThemeManager().blackColor,
                      fontSize: 14,
                    ),
                    codeblockDecoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                      border: ThemeManager().defaultBorder(),
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
              },
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
