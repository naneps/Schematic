import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/common/input/x_field.dart';
import 'package:schematic/app/models/promp.model.dart';
import 'package:schematic/app/themes/theme.dart';

class PromptField extends GetView<PromptFieldWidgetController> {
  final Field field;
  final VoidCallback? onRemove;
  final int index;

  const PromptField({
    super.key,
    required this.field,
    this.onRemove,
    required this.index,
  });

  @override
  PromptFieldWidgetController get controller =>
      Get.put(PromptFieldWidgetController(field: field.obs), tag: tag);

  @override
  String? get tag => key.toString() + index.toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: XTextField(
                    labelText: "Key",
                    hintText: "e.g name",
                    onChanged: (value) {
                      controller.field?.value.key = value;
                      controller.field?.refresh();
                    },
                    initialValue: controller.field?.value.key,
                    prefixIcon: MdiIcons.text,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<FieldType>(
                    items: [
                      ...FieldType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          alignment: Alignment.centerLeft,
                          child: Text(type.name),
                        );
                      })
                    ],
                    hint: Text(
                      "Type",
                      style: Get.textTheme.bodyMedium,
                    ),
                    style: Get.textTheme.bodyMedium,
                    isDense: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(MdiIcons.formatListBulleted),
                    ),
                    onChanged: (value) {
                      controller.field?.value.type = value;
                      if (value == FieldType.array) {
                        // Reset subType if changing to array
                        controller.field?.value.subType = null;
                      }
                      controller.field?.refresh();
                    },
                    value: controller.field?.value.type,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton.outlined(
                  onPressed: onRemove,
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(30, 30),
                    foregroundColor: ThemeApp.dangerColor,
                    side: BorderSide(color: ThemeApp.dangerColor),
                  ),
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (controller.field!.value.type == FieldType.object)
              _buildNestedFields(context, controller.field!.value),
            if (controller.field!.value.type == FieldType.array)
              _buildArrayTypeSelection(context, controller.field!.value),
          ],
        );
      }),
    );
  }

  Widget _buildArrayDescription(BuildContext context, Field arrayField) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: XTextField(
        labelText: "Description",
        hintText: "e.g list of images url",
        initialValue: arrayField.description,
        onChanged: (value) {
          arrayField.description = value;
          controller.field?.refresh();
        },
        prefixIcon: MdiIcons.textBox,
      ),
    );
  }

  Widget _buildArrayTypeSelection(BuildContext context, Field arrayField) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonFormField<FieldType>(
            items: [
              DropdownMenuItem(
                value: FieldType.string,
                child: Text(
                  'Array of Strings',
                  style: Get.textTheme.bodyMedium,
                ),
              ),
              DropdownMenuItem(
                value: FieldType.number,
                child: Text(
                  'Array of Numbers',
                  style: Get.textTheme.bodyMedium,
                ),
              ),
              DropdownMenuItem(
                value: FieldType.object,
                child: Text(
                  'Array of Objects',
                  style: Get.textTheme.bodyMedium,
                ),
              ),
            ],
            hint: const Text("Array Type"),
            isDense: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(MdiIcons.formatListBulleted),
            ),
            onChanged: (value) {
              arrayField.subType = value;
              if (value == FieldType.object) {
                arrayField.subFields ??= [];
              } else {
                arrayField.subFields = []; // Ensure subFields is reset
              }
              controller.field?.refresh();
            },
            value: arrayField.subType,
          ),
        ),
        const SizedBox(height: 10),
        if (arrayField.subType == FieldType.object)
          _buildNestedFields(context, arrayField),
        if (arrayField.subType != FieldType.object)
          _buildArrayDescription(context, arrayField),
      ],
    );
  }

  Widget _buildNestedFields(BuildContext context, Field parentField) {
    return ExpansionTile(
      title: Text(
        'Child From: ${parentField.key}',
        style: Get.textTheme.labelMedium,
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
      tilePadding: const EdgeInsets.only(left: 20, right: 20),
      childrenPadding: const EdgeInsets.only(left: 20, right: 20),
      trailing: IconButton(
        onPressed: () {
          parentField.subFields ??= [];
          parentField.subFields!.add(Field()); // Add new subfield
          controller.field?.refresh();
        },
        icon: const Icon(MdiIcons.plus),
        color: ThemeApp.primaryColor,
      ),
      children: [
        ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: Get.height * 0.4, minHeight: 50),
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              physics: const BouncingScrollPhysics(),
              itemCount: parentField.subFields?.length,
              itemBuilder: (context, index) {
                final field = parentField.subFields![index];
                return PromptField(
                  index: index,
                  field: field,
                  key: const ValueKey("child"),
                  onRemove: () {
                    parentField.subFields!.removeAt(index);
                    controller.field?.refresh();
                  },
                );
              },
            )),
      ],
    );
  }
}

class PromptFieldWidgetController extends GetxController {
  Rx<Field>? field = Field().obs;

  PromptFieldWidgetController({
    this.field,
  });
}
