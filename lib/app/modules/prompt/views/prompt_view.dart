import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/responsive_layout.dart';
import 'package:schematic/app/modules/prompt/views/output_prompt_view.dart';
import 'package:schematic/app/modules/prompt/views/preview_prompt_view.dart';
import 'package:schematic/app/modules/prompt/widgets/form_prompt_field.dart';

import '../controllers/prompt_controller.dart';

class PromptView extends GetView<PromptController> {
  const PromptView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        tablet: Row(
          children: [
            const Expanded(
              child: FormPromptField(),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    ThemeManager().defaultShadow(),
                  ],
                  border: Border.all(
                    color: ThemeManager().blackColor,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerHeight: 0,
                        padding: EdgeInsets.zero,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ThemeManager().primaryColor,
                          boxShadow: [
                            ThemeManager().defaultShadow(),
                          ],
                        ),
                        tabs: [
                          Tab(
                            child: Text(
                              "Preview Prompt",
                              style: Get.textTheme.labelMedium,
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Output",
                              style: Get.textTheme.labelMedium,
                            ),
                          ),
                        ],
                        controller: controller.tabController,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabController,
                        children: [
                          PreviewPromptView(controller: controller),
                          OutputPromptView(controller: controller),
                        ],
                      ),
                    )
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
