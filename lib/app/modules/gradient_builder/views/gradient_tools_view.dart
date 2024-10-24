import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/typewriter_markdown.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/commons/ui/scroll_to_hide.widget.dart';
import 'package:schematic/app/modules/container_builder/views/container_builder_view.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_editor_controller.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_tools_controller.dart';
import 'package:schematic/app/modules/gradient_builder/views/gradient_editor_view.dart';

class GradientToolsView extends GetView<GradientToolsController> {
  const GradientToolsView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    ScrollController scrollController = ScrollController();
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        width: 300,
        color: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ThemeManager().blackColor, width: 2),
          boxShadow: [ThemeManager().defaultShadow()],
        ),
        child: Column(
          children: [
            TabBar(
              controller: controller.tabController,
              tabs: const [Tab(text: 'Gradient'), Tab(text: 'Shape')],
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.tabController,
                children: [
                  GradientEditorView(
                    onChanged: (gradient) {
                      controller.onGradientChanged(gradient);
                    },
                  ),
                  const ContainerBuilderView(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ScrollToHide(
              height: 45,
              controller: Get.find<GradientEditorController>().scrollController,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: NeoButton(
                        onPressed: () {
                          // controller.onSave();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeManager().infoColor,
                          textStyle: Get.textTheme.labelMedium,
                        ),
                        child: const Text("Make Template"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: NeoButton.icon(
                        onPressed: () {
                          // controller.onGetCode();
                          showCode(scaffoldKey);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeManager().successColor,
                          textStyle: Get.textTheme.labelMedium,
                        ),
                        icon: Icon(MdiIcons.codeTags),
                        label: const Text("Get Code"),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showCode(GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState!.showBottomSheet(
      (context) {
        return Container(
          width: Get.width,
          padding: const EdgeInsets.all(16),
          height: Get.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: ThemeManager().defaultBorder(),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: controller.code.value.isNotEmpty
                    ? TypewriterMarkdown(
                        controller.code.value,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(MdiIcons.codeTags),
                          const Text(
                            "Nothings code here",
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
      backgroundColor: Colors.transparent,
    );
  }
}
