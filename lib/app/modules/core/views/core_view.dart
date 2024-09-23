import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
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
                  color: ThemeManager().primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    ThemeManager().defaultShadow(),
                  ],
                  border: Border.all(
                    color: ThemeManager().blackColor,
                    width: 2,
                  ),
                ),
                child: Obx(() {
                  return Column(
                    children: [
                      TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Tab(
                            child: Text(
                              "Preview Prompt",
                              style: Get.textTheme.labelLarge,
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Output",
                              style: Get.textTheme.labelLarge,
                            ),
                          ),
                        ],
                        controller: controller.tabController,
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              ThemeManager().defaultShadow(),
                            ],
                          ),
                          child: TabBarView(
                            controller: controller.tabController,
                            children: [
                              Markdown(
                                data: controller.prompt.value.toMarkdown(),
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
                                    fontSize: 16,
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
                              ),
                              OutputPromptView(controller: controller),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OutputPromptView extends StatelessWidget {
  final CoreController controller;

  const OutputPromptView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeManager().blackColor,
        borderRadius: BorderRadius.circular(10),
      ),
      // padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                    : SingleChildScrollView(
                        child: SizedBox(
                          height: Get.height,
                          child: TypewriterMarkdown(
                            Get.find<FormPromptFieldController>().output.value,
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
    );
  }
}
