import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/inputs/colors_picker.widget.dart';
import 'package:schematic/app/commons/ui/inputs/neo_dropdown_formfield.dart';
import 'package:schematic/app/enums/gradient.enum.dart';
import 'package:schematic/app/models/gradient.model.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_editor_controller.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class GradientEditorView extends GetView<GradientEditorController> {
  final Function(GradientModel)? onChanged;
  const GradientEditorView({super.key, this.onChanged});

  @override
  get controller => Get.put(GradientEditorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
          _buildColorPicker(context),
          const SizedBox(height: 10),
          _buildAlignmentSection(context),
          const SizedBox(height: 10),
          Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Custom End & Begin Alignment",
                    style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Begin X",
                        style: Theme.of(context).textTheme.labelMedium),
                    SfSlider(
                      value: controller.gradient.value.begin!.x,
                      min: -1,
                      max: 1,
                      onChanged: (value) {
                        controller.onBeginXChanged(value);
                        controller.gradient.refresh();
                        onChanged?.call(controller.gradient.value);
                      },
                      showLabels: true,
                      showDividers: true,
                      interval: 0.5,
                      enableTooltip: true,
                      thumbIcon: Icon(MdiIcons.chevronRight),
                      activeColor: ThemeManager().primaryColor,
                      inactiveColor: ThemeManager().secondaryColor,
                    ),
                    const SizedBox(height: 10),
                    Text("Begin Y",
                        style: Theme.of(context).textTheme.labelMedium),
                    SfSlider(
                      value: controller.gradient.value.begin!.y,
                      min: -1,
                      max: 1,
                      onChanged: (value) {
                        controller.onBeginYChanged(value);
                        controller.gradient.refresh();
                        onChanged?.call(controller.gradient.value);
                      },
                      showLabels: true,
                      showDividers: true,
                      interval: 0.5,
                      enableTooltip: true,
                      tooltipShape: const SfPaddleTooltipShape(),
                      thumbIcon: Icon(MdiIcons.chevronRight),
                      activeColor: ThemeManager().primaryColor,
                      inactiveColor: ThemeManager().secondaryColor,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("End X",
                        style: Theme.of(context).textTheme.labelMedium),
                    SfSlider(
                      value: controller.gradient.value.end!.x,
                      min: -1,
                      max: 1,
                      onChanged: (value) {
                        controller.onEndXChanged(value);
                        controller.gradient.refresh();
                        onChanged?.call(controller.gradient.value);
                      },
                      showLabels: true,
                      showDividers: true,
                      interval: 0.5,
                      enableTooltip: true,
                      thumbIcon: Icon(MdiIcons.chevronRight),
                      activeColor: ThemeManager().primaryColor,
                      inactiveColor: ThemeManager().secondaryColor,
                    ),
                    const SizedBox(height: 10),
                    Text("End Y",
                        style: Theme.of(context).textTheme.labelMedium),
                    SfSlider(
                      value: controller.gradient.value.end!.y,
                      min: -1,
                      max: 1,
                      onChanged: (value) {
                        controller.onEndYChanged(value);
                        controller.gradient.refresh();
                        onChanged?.call(controller.gradient.value);
                      },
                      showLabels: true,
                      showDividers: true,
                      interval: 0.5,
                      enableTooltip: true,
                      tooltipShape: const SfPaddleTooltipShape(),
                      thumbIcon: Icon(MdiIcons.chevronRight),
                      activeColor: ThemeManager().primaryColor,
                      inactiveColor: ThemeManager().secondaryColor,
                    ),
                  ],
                ),
              ],
            );
          })
        ],
      ),
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
      ],
    );
  }

  Widget _buildColorPicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Colors", style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 5),
        ColorPickerWidget(
          minColors: 2,
          initialColors: [
            ThemeManager().primaryColor,
            ThemeManager().secondaryColor,
          ],
          onColorsChanged: (value) {
            controller.gradient.value.colors = value.obs;
            controller.gradient.refresh();
            onChanged?.call(controller.gradient.value);
          },
        ),
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
}
