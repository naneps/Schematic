import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/responsive_layout.dart';
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
        tablet: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: ThemeManager().defaultBorder(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Yours Template",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const Divider(),
                    Expanded(
                      child: StreamBuilder(
                        stream:
                            controller.gradientRepository.getUserGradients(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                  "Something went wrong ${snapshot.error}"),
                            );
                          } else {
                            return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final gradient = snapshot.data![index];
                                return Container(
                                  decoration: BoxDecoration(
                                    gradient:
                                        gradient.gradient!.toGradient().value,
                                    borderRadius: BorderRadius.circular(10),
                                    border: ThemeManager().defaultBorder(
                                      color: gradient.gradient!.colors.last,
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text(gradient.name!),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
