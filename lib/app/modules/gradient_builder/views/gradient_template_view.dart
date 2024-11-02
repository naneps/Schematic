import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/commons/ui/inputs/neo_dropdown_formfield.dart';
import 'package:schematic/app/commons/ui/loading.widget.dart';
import 'package:schematic/app/commons/ui/overlays/noe_dialog.dart';
import 'package:schematic/app/enums/gradient.enum.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_template_controller.dart';
import 'package:schematic/app/modules/gradient_builder/widgets/gradient_tile.dart';

class FilterGradient extends StatelessWidget {
  final GradientTemplateController controller;

  const FilterGradient({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeManager().scaffoldBackgroundColor,
        border: ThemeManager().defaultBorder(),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                "Filter",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  MdiIcons.close,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          //   ToggleSwitch(
          //     customHeights: const [30, 30, 30],
          //     minHeight: 30,
          //     cornerRadius: 10,
          //     labels: const [
          //       "All",
          //       "Published",
          //       "Unpublished",
          //     ],
          //     onToggle: (index) {
          //       controller.filterType.value = GradientType.values[index!].name;
          //     },
          //     inactiveBgColor: ThemeManager().scaffoldBackgroundColor,
          //     inactiveFgColor: ThemeManager().blackColor,
          //     activeFgColor: ThemeManager().backgroundColor,
          //     totalSwitches: 3,
          //     initialLabelIndex: controller.filterType.value == "all"
          //         ? 0
          //         : GradientType.values.indexWhere(
          //             (type) => type.name == controller.filterType.value,
          //           ),
          //   ),
          //   const SizedBox(height: 10),
          NeoDropdown<String>(
            value: controller.filterType.value,
            items: [
              const DropdownMenuItem(
                value: "all",
                child: Text("all"),
              ),
              ...GradientType.values.map(
                (type) => DropdownMenuItem(
                  value: type.name,
                  child: Text(type.name),
                ),
              )
            ],
            hint: const Text("Gradient Type"),
            onChanged: (type) {
              controller.filterType.value = type!;
            },
            isDense: true,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 30,
            child: NeoButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeManager().infoColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                controller.resetFilter();
                Navigator.pop(context);
              },
              child: const Text("Reset"),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 30,
            child: NeoButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeManager().successColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                controller.streamGradients();
                Navigator.pop(context);
              },
              child: const Text("Apply"),
            ),
          ),
        ],
      ),
    );
  }
}

class GradientTemplateView extends GetView<GradientTemplateController> {
  const GradientTemplateView({super.key});

  @override
  GradientTemplateController get controller => Get.put(
        GradientTemplateController(),
      );

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: controller.scaffoldMessenger,
      child: Scaffold(
        extendBody: true,
        key: controller.scaffoldKey,
        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: ThemeManager().defaultBorder(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Your Gradients",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      showBottomFilterSheet();
                    },
                    child: Icon(
                      MdiIcons.filterVariant,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),
              Expanded(
                child: controller.obx(
                  (snapshot) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      shrinkWrap: true,
                      cacheExtent: 1000,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.gradients.length,
                      itemBuilder: (context, index) {
                        final gradient = controller.gradients[index];
                        return GradientTile(
                          gradient: gradient,
                          onUse: () {
                            controller.onUseGradient(
                              gradient,
                            );
                          },
                          onPublish: () {
                            NeoDialog.showDialogByKey(
                              context,
                              controller.scaffoldKey,
                              NeoDialogType.warning,
                              title: "Publish Gradient",
                              message:
                                  "Are you sure you want to publish this ${gradient.name}, when published, it can be appeared any users",
                              onConfirm: () {
                                controller.onPublishGradient(gradient);
                                Navigator.pop(context);
                              },
                            );
                          },
                          onDelete: () {
                            NeoDialog.showDialogByKey(
                              context,
                              controller.scaffoldKey,
                              NeoDialogType.warning,
                              title: "Delete Gradient",
                              message:
                                  "Are you sure you want to delete this ${gradient.name}",
                              onConfirm: () {
                                controller.onRemoveGradient(gradient);
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                  onError: (error) {
                    return Center(
                      child: Text(
                        "Something went wrong $error",
                      ),
                    );
                  },
                  onLoading: const LoadingWidget(),
                  onEmpty: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "You don't have any template yet",
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Create your own template",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 20),
                      Icon(
                        MdiIcons.gradientHorizontal,
                        color: Theme.of(context).primaryColor,
                        size: 100,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showBottomFilterSheet() {
    controller.scaffoldKey.currentState!.showBottomSheet(
      (context) {
        return FilterGradient(controller: controller);
      },
      backgroundColor: Colors.black.withOpacity(0.3),
      elevation: 0,
      constraints: BoxConstraints(
        maxHeight: Get.height * 0.7,
        maxWidth: Get.width * 0.8,
      ),
    );
  }
}
