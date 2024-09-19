import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/typewriter_markdown.dart';
import 'package:schematic/app/modules/prompt/controllers/form_prompt_field.dart';
import 'package:schematic/app/modules/prompt/views/prompt_view.dart';

import '../controllers/core_controller.dart';

class CoreView extends GetView<CoreController> {
  const CoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schematic Studio',
          style: Get.textTheme.labelLarge,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: IconButton.filled(
              onPressed: () {},
              icon: const Icon(
                MdiIcons.github,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      drawer: const Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            const Expanded(
              child: PromptView(),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(
                        () {
                          return SingleChildScrollView(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: Get.width,
                              child: TypewriterMarkdown(
                                Get.find<FormPromptFieldController>()
                                    .output
                                    .value,
                              ),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
