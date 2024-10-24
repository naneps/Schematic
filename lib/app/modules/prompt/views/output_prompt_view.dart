import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/typewriter_markdown.dart';
import 'package:schematic/app/commons/ui/loading.widget.dart';
import 'package:schematic/app/modules/prompt/controllers/form_prompt_field.dart';
import 'package:schematic/app/modules/prompt/controllers/prompt_controller.dart';

class OutputPromptView extends StatelessWidget {
  final PromptController controller;

  const OutputPromptView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: LoadingWidget(
                text: [
                  'Generating...',
                  'This may take a while...',
                  'Please be patient...',
                ],
              ),
            );
          } else if (controller.output.value.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    MdiIcons.fileDocumentOutline,
                    color: ThemeManager().secondaryColor,
                    size: 40,
                  ),
                  Text(
                    'No results yet',
                    style: Get.textTheme.labelLarge!.copyWith(
                      color: ThemeManager().secondaryColor,
                    ),
                  ),
                  Text(
                    'Try adjusting your input or refresh to generate something new.',
                    style: Get.textTheme.bodySmall,
                  ),
                ],
              ),
            );
          } else {
            return SizedBox(
              height: Get.height,
              child: TypewriterMarkdown(
                Get.find<FormPromptFieldController>().output.value,
              ),
            );
          }
        },
      ),
    );
  }
}
