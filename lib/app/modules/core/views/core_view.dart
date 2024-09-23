import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/modules/prompt/views/output_prompt_view.dart';
import 'package:schematic/app/modules/prompt/views/preview_prompt_view.dart';
import 'package:schematic/app/modules/prompt/views/prompt_view.dart';
import 'package:url_launcher/url_launcher.dart';

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
              onPressed: () async {
                // launchUrl(
                //url launcher
                await launchUrl(
                  Uri.parse('https://github.com/naneps/schematic'),
                  mode: LaunchMode.externalApplication,
                );
              },
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
        child: context.isPhone
            ? Column(children: [
                const Expanded(
                  child: PromptView(),
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            color: ThemeManager().primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                      ThemeManager().defaultShadow(),
                    ])))
              ])
            : Row(
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
                                    PreviewPromptView(controller: controller),
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
