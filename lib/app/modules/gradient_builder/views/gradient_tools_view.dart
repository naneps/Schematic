import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/modules/container_builder/views/container_builder_view.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_tools_controller.dart';

class GradientToolsView extends GetView<GradientToolsController> {
  const GradientToolsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Container(),
                const ContainerBuilderView(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
