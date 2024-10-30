import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/ui/responsive_layout.dart';
import 'package:schematic/app/modules/gradient_builder/views/gradient_template_view.dart';
import 'package:schematic/app/modules/gradient_builder/views/gradient_tools_view.dart';

import '../controllers/gradient_builder_controller.dart';

class GradientBuilderView extends GetView<GradientBuilderController> {
  const GradientBuilderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gradient Builder'),
        centerTitle: true,
      ),
      body: ResponsiveLayout(
        padding: const EdgeInsets.all(20),
        mobile: Column(
          children: [
            const Expanded(
              flex: 2,
              child: GradientTemplateView(),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                child: Obx(() {
                  return controller.container.value.widget();
                }),
              ),
            ),
            const SizedBox(height: 20),
            const Expanded(
              flex: 3,
              child: GradientToolsView(),
            ),
          ],
        ),
        tablet: Row(
          children: [
            const Expanded(
              flex: 2,
              child: GradientTemplateView(),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                child: Obx(() {
                  return controller.container.value.widget();
                }),
              ),
            ),
            const SizedBox(width: 20),
            const Expanded(
              flex: 3,
              child: GradientToolsView(),
            ),
          ],
        ),
      ),
    );
  }
}
