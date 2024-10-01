import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/typewriter_markdown.dart';
import 'package:schematic/app/modules/core/controllers/core_controller.dart';
import 'package:schematic/app/modules/prompt/controllers/form_prompt_field.dart';

class OutputPromptView extends StatelessWidget {
  final CoreController controller;

  const OutputPromptView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          children: [],
        ),
        Expanded(
          child: Obx(
            () {
              return controller.isLoading.value
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingAnimationWidget.staggeredDotsWave(
                          color: ThemeManager().primaryColor,
                          size: 40,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Generating...',
                          style: Get.textTheme.labelLarge!.copyWith(
                            color: ThemeManager().secondaryColor,
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: Get.height,
                      child: TypewriterMarkdown(
                        Get.find<FormPromptFieldController>().output.value,
                      ),
                    );
            },
          ),
        ),
        // Expanded(
        //   child: Obx(
        //     () {
        //       return Container(
        //         margin: const EdgeInsets.all(10),
        //         width: Get.width,
        //         child: CodePreview(
        //           controller.prompt.value.toMarkdown(),
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
