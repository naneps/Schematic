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
                      child: TabBarView(
                        controller: controller.tabController,
                        children: [
                          Expanded(
                              child: Markdown(
                            data: controller.prompt.value.toMarkdown(),
                            styleSheet: MarkdownStyleSheet(
                              p: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )),
                          Expanded(
                            child: OutputPromptView(controller: controller),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class OutputPromptView extends StatelessWidget {
  const OutputPromptView({
    super.key,
    required this.controller,
  });

  final CoreController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeManager().blackColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
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
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          width: Get.width,
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
