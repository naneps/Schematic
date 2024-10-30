import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/commons/ui/inputs/colors_picker.widget.dart';
import 'package:schematic/app/commons/ui/inputs/neo_dropdown_formfield.dart';
import 'package:schematic/app/enums/gradient.enum.dart';
import 'package:schematic/app/models/builder_models/gradient.model.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_editor_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class GradientEditorView extends GetView<GradientEditorController> {
  final Function(GradientModel)? onChanged;
  const GradientEditorView({super.key, this.onChanged});

  @override
  get controller => Get.put(GradientEditorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: const BoxDecoration(
              // gradient: controller.gradient.value.toGradient().value,
              ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 110,
              sigmaY: 100,
              tileMode: TileMode.mirror,
            ),
            blendMode: BlendMode.colorBurn,
            child: ListView(
              controller: controller.scrollController,
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownSection(
                        context: context,
                        label: "Gradient Type",
                        icon: MdiIcons.gradientHorizontal,
                        value: controller.gradient.value.type,
                        items: GradientType.values.map(
                          (type) => DropdownMenuItem(
                            value: type,
                            child: Text(type.name),
                          ),
                        ),
                        onChanged: (value) {
                          controller.gradient.value.type = value!;
                          controller.gradient.refresh();
                          onChanged?.call(controller.gradient.value);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildDropdownSection(
                        context: context,
                        label: "Gradient Mode",
                        icon: MdiIcons.gradientHorizontal,
                        value: controller.gradient.value.tileMode,
                        items: TileModeType.values.map(
                          (type) => DropdownMenuItem(
                            value: type,
                            child: Text(type.name),
                          ),
                        ),
                        onChanged: (value) {
                          controller.gradient.value.tileMode = value!;
                          controller.gradient.refresh();
                          onChanged?.call(controller.gradient.value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                _buildColorPicker(context),
                const SizedBox(height: 15),
                SizedBox(
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Stops",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 40,
                            child: NeoButton(
                              onPressed: () {
                                if (controller.gradient.value.stops == null) {
                                  controller.onAddStops();
                                } else {
                                  controller.onClearStops();
                                }
                                onChanged?.call(controller.gradient.value);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.gradient.value.stops == null
                                        ? ThemeManager().successColor
                                        : ThemeManager().dangerColor,
                                textStyle: Get.textTheme.labelMedium!,
                              ),
                              child: Text(
                                controller.gradient.value.stops == null
                                    ? "Add Stops"
                                    : "Clear Stops",
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.9,
                        ),
                        shrinkWrap: true,
                        itemCount: controller.gradient.value.stops?.length ?? 0,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final stop = controller.gradient.value.stops![index];
                          return Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: ThemeManager().defaultBorder(
                                  color: stop.color,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      const Text("Stop Color "),
                                      CircleAvatar(
                                        radius: 5,
                                        backgroundColor: stop.color,
                                      )
                                    ],
                                  ),
                                  _buildSlider(
                                    context: context,
                                    label: "Position",
                                    hasLabel: false,
                                    min: 0,
                                    max: 1,
                                    value: stop.stop,
                                    onChanged: (value) {
                                      stop.stop = value;
                                      controller.gradient.refresh();
                                      onChanged
                                          ?.call(controller.gradient.value);
                                    },
                                  )
                                ],
                              ));
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                if (controller.gradient.value.type == GradientType.radial) ...[
                  _buildSlider(
                    context: context,
                    label: "Radius",
                    value: controller.gradient.value.radius,
                    min: 0,
                    max: 1,
                    hasLabel: true,
                    onChanged: (value) {
                      controller.gradient.value.radius = value;
                      onChanged?.call(controller.gradient.value);
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSlider(
                            context: context,
                            label: "Center X",
                            value: controller.gradient.value.center!.x,
                            min: 0,
                            max: 1,
                            hasLabel: true,
                            onChanged: (value) {
                              controller.gradient.value.center!.x = value;
                              onChanged?.call(controller.gradient.value);
                            }),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: _buildSlider(
                          context: context,
                          label: "Center Y",
                          value: controller.gradient.value.center!.y,
                          min: 0,
                          max: 1,
                          hasLabel: true,
                          onChanged: (value) {
                            controller.gradient.value.center!.y = value;
                            onChanged?.call(controller.gradient.value);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
                if (controller.gradient.value.type == GradientType.linear) ...[
                  _buildAlignmentSection(context),
                ],
                if (controller.gradient.value.type == GradientType.sweep) ...[
                  Row(
                    children: [
                      Expanded(
                        child: _buildSlider(
                          context: context,
                          label: "Start Angle",
                          value: controller.gradient.value.startAngle,
                          min: 0,
                          max: 1,
                          hasLabel: true,
                          onChanged: (value) {
                            controller.gradient.value.startAngle = value;
                            onChanged?.call(controller.gradient.value);
                          },
                        ),
                      ),
                      Expanded(
                        child: _buildSlider(
                          context: context,
                          label: "End Angle",
                          value: controller.gradient.value.endAngle,
                          min: 0,
                          max: 1,
                          hasLabel: true,
                          onChanged: (value) {
                            controller.gradient.value.endAngle = value;
                            onChanged?.call(controller.gradient.value);
                          },
                        ),
                      ),
                    ],
                  )
                ]
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAlignmentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Alignment", style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: _buildDropdownSection(
                context: context,
                label: "Begin Alignment",
                icon: MdiIcons.gradientHorizontal,
                value: controller.gradient.value.begin!.type,
                items: AlignmentType.values.map(
                  (type) => DropdownMenuItem(
                    value: type,
                    child: Text(type.name),
                  ),
                ),
                onChanged: (value) {
                  controller.onBeginAlignmentChanged(value!);
                  onChanged?.call(controller.gradient.value);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildDropdownSection(
                context: context,
                label: "End Alignment",
                icon: MdiIcons.gradientHorizontal,
                value: controller.gradient.value.end!.type,
                items: AlignmentType.values.map(
                  (type) => DropdownMenuItem(
                    value: type,
                    child: Text(type.name),
                  ),
                ),
                onChanged: (value) {
                  controller.onEndAlignmentChanged(value!);
                  onChanged?.call(controller.gradient.value);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Custom End & Begin Alignment",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildSlider(
                    context: context,
                    label: "Begin X",
                    value: controller.gradient.value.begin!.x,
                    onChanged: controller.onBeginXChanged,
                  ),
                ),
                Expanded(
                  child: _buildSlider(
                    context: context,
                    label: "Begin Y",
                    value: controller.gradient.value.begin!.y,
                    onChanged: controller.onBeginYChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildSlider(
                    context: context,
                    label: "End X",
                    value: controller.gradient.value.end!.x,
                    onChanged: controller.onEndXChanged,
                  ),
                ),
                Expanded(
                  child: _buildSlider(
                    context: context,
                    label: "End Y",
                    value: controller.gradient.value.end!.y,
                    onChanged: controller.onEndYChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ],
    );
  }

  Widget _buildColorPicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Colors", style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 5),
        Obx(() {
          return ColorPickerWidget(
            minColors: 2,
            initialColors: controller.gradient.value.colors,
            onColorsChanged: (value) {
              controller.onColorsChanged(value);
              onChanged?.call(controller.gradient.value);
            },
          );
        }),
      ],
    );
  }

  Widget _buildDropdownSection({
    required BuildContext context,
    required String label,
    required IconData icon,
    required dynamic value,
    required Iterable<DropdownMenuItem<dynamic>> items,
    required ValueChanged<dynamic>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 10),
        NeoDropdown(
          value: value,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            prefixIcon: Icon(icon),
          ),
          items: items.toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSlider({
    required BuildContext context,
    required String label,
    required double value,
    double min = -1,
    double max = 1,
    bool hasLabel = true,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (hasLabel) ...[
          Text(label, style: Theme.of(context).textTheme.labelMedium),
        ],
        SfSliderTheme(
          data: SfSliderThemeData(
            activeTrackColor: ThemeManager().primaryColor,
            inactiveTrackColor: ThemeManager().blackColor,
            thumbColor: ThemeManager().backgroundColor,
            inactiveDividerColor: ThemeManager().blackColor,
            activeDividerColor: ThemeManager().primaryColor,
            tooltipBackgroundColor: ThemeManager().primaryColor,
            thumbRadius: 15,
            trackCornerRadius: 10,
            thumbStrokeColor: ThemeManager().primaryColor,
            inactiveTrackHeight: 0.5,
            thumbStrokeWidth: 2,
            tooltipTextStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: SfSlider(
            value: value,
            min: min,
            max: max,
            onChanged: (newValue) {
              onChanged(newValue);
              controller.gradient.refresh();
              this.onChanged?.call(controller.gradient.value);
            },
            showLabels: true,
            showDividers: true,
            interval: 0.5,
            enableTooltip: true,
            thumbIcon: Icon(MdiIcons.chevronRight),
          ),
        ),
      ],
    );
  }
}
