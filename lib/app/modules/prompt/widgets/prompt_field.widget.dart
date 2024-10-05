import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_icon_button.dart';
import 'package:schematic/app/commons/ui/inputs/neo_dropdown_formfield.dart';
import 'package:schematic/app/commons/ui/inputs/x_input.dart';
import 'package:schematic/app/enums/type_field.enum.dart';
import 'package:schematic/app/models/field.model.dart';

class PromptField extends GetView<PromptFieldWidgetController> {
  final Field field;
  final VoidCallback? onRemove;
  final RxBool isValidated;
  List<String> alReadyUsedKeys = [];
  PromptField({
    super.key,
    required this.field,
    this.onRemove,
    required this.isValidated,
    required this.alReadyUsedKeys,
  });

  @override
  PromptFieldWidgetController get controller =>
      Get.put<PromptFieldWidgetController>(
        PromptFieldWidgetController(
          field: Rx(field),
        ),
        tag: key.toString(),
      ); // Use Get.find instead of Get.put

  @override
  String get tag => key.toString();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      autoRemove: false,
      dispose: (_) {
        Get.delete<PromptFieldWidgetController>(tag: tag);
      },
      builder: (ctrl) {
        return Container(
          margin: const EdgeInsets.only(
            bottom: 10,
            left: 5,
            right: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: ThemeManager().blackColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [ThemeManager().defaultShadow()],
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
                Form(
                  key: controller.formKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textBaseline: TextBaseline.ideographic,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Obx(() {
                          return XInput(
                            label: "Key",
                            hintText: "e.g name",
                            onChanged: (value) {
                              controller.field?.value.key!(value);
                              controller.field?.refresh();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required";
                              }
                              if (alReadyUsedKeys.contains(value)) {
                                return "Key must be unique";
                              }
                              return null;
                            },
                            initialValue: controller.field?.value.key?.value,
                            prefixIcon: Icon(MdiIcons.formatListBulleted),
                          );
                        }),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 5,
                        child: NeoDropdown<FieldType>(
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
                          decoration: InputDecoration(
                            prefixIcon: Icon(MdiIcons.formatListBulleted),
                          ),
                          onChanged: (value) {
                            controller.field?.value.type?.value = value!;
                            if (value == FieldType.array) {
                              controller.field?.value.subType?.value =
                                  FieldType.string;
                            }
                            controller.field?.refresh();
                          },
                          value: controller.field?.value.type?.value,
                        ),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: NeoIconButton(
                          onPressed: () {
                            onRemove?.call();
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(30, 30),
                            backgroundColor: Colors.white,
                            shape: const CircleBorder(),
                            side: const BorderSide(color: Colors.black),
                            foregroundColor: ThemeManager().errorColor,
                          ),
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                ),
                if (controller.field?.value.type?.value != FieldType.array &&
                    controller.field?.value.type?.value !=
                        FieldType.object) ...[
                  const SizedBox(height: 15),
                  XInput(
                    label: "description",
                    hintText: "specify content of this field",
                    maxLines: 2,
                    prefixIcon: Icon(MdiIcons.text),
                    initialValue: controller.field?.value.description?.value,
                    onChanged: (val) {
                      controller.field?.value.description?.value = val;
                    },
                  )
                ],
                if (controller.field?.value.type?.value ==
                    FieldType.object) ...[
                  const SizedBox(height: 10),
                  _buildNestedFields(context, controller.field!.value),
                ],
                if (controller.field?.value.type?.value == FieldType.array) ...[
                  const SizedBox(height: 10),
                  _buildArrayTypeSelection(context, controller.field!.value),
                ],
              ],
            );
          }),
        );
      },
    );
  }

  Widget _buildArrayTypeSelection(BuildContext context, Field arrayField) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            "Additional Properties",
            style: Get.textTheme.labelSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: NeoDropdown<FieldType>(
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
                        'Array of Object',
                        style: Get.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                  hint: const Text("Array Type"),
                  isDense: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(MdiIcons.formatListBulleted),
                  ),
                  onChanged: (value) {
                    arrayField.subType!.value = value!;
                    if (value == FieldType.object) {
                      arrayField.subFields ??= RxList<Field>([]);
                    } else {
                      arrayField.subFields =
                          RxList<Field>(); // Ensure subFields is reset
                    }
                    controller.field?.refresh();
                  },
                  value: arrayField.subType!.value,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: XInput(
                label: "Count Data",
                hintText: "e.g 10",
                prefixIcon: Icon(MdiIcons.numeric0BoxOutline),
                keyboardType: TextInputType.number,
                initialValue: arrayField.count?.value.toString(),
                onChanged: (value) {
                  arrayField.count!.value = int.parse(value);
                  controller.field?.refresh();
                },
              )),
            ],
          ),
        ),
        const SizedBox(height: 10),
        if (arrayField.subType!.value == FieldType.object)
          _buildNestedFields(context, arrayField),
        if (arrayField.subType!.value != FieldType.object)
          _buildDescription(context, arrayField),
      ],
    );
  }

  Widget _buildDescription(BuildContext context, Field arrayField) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: XInput(
        label: "Description",
        hintText: "e.g list of images url",
        initialValue: arrayField.description?.value,
        onChanged: (value) {
          arrayField.description!(value);
          controller.field?.refresh();
        },
        prefixIcon: Icon(MdiIcons.formatListBulleted),
      ),
    );
  }

  Widget _buildNestedFields(BuildContext context, Field parentField) {
    return ExpansionTile(
      title: Text(
        'Child From: ${parentField.key}',
        style: Get.textTheme.labelMedium,
      ),
      initiallyExpanded: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide.none,
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
      tilePadding: const EdgeInsets.only(left: 20, right: 20),
      childrenPadding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      trailing: NeoIconButton(
        onPressed: () {
          controller.addField();
          controller.field?.refresh();
        },
        icon: Icon(MdiIcons.plus),
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeManager().infoColor,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(0),
          side: BorderSide(color: ThemeManager().blackColor),
          foregroundColor: ThemeManager().blackColor,
          minimumSize: const Size(20, 20),
        ),
        color: ThemeManager().primaryColor,
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints:
              const BoxConstraints(maxHeight: double.infinity, minHeight: 50),
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: parentField.subFields?.length,
            itemBuilder: (context, idx) {
              final field = parentField.subFields![idx];
              return PromptField(
                field: field,
                isValidated: field.allSubFieldKeyUnique.obs,
                alReadyUsedKeys: [
                  ...parentField.subFields!.map((e) => e.key!.value),
                ],
                key: ValueKey(
                    'child:${parentField.id}:${field.id}'), // Ensure unique key
                onRemove: () {
                  parentField.subFields!.removeWhere(
                    (element) => element.id == field.id,
                  );
                  controller.field?.refresh();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class PromptFieldWidgetController extends GetxController {
  Rx<Field>? field = Field().obs;
  final formKey = GlobalKey<FormState>();
  PromptFieldWidgetController({this.field});
  void addField() {
    field!.value.subFields!.add(
      Field(
        key: ''.obs,
        type: FieldType.string.obs,
        subType: FieldType.string.obs,
        subFields: RxList<Field>([]),
        description: ''.obs,
        count: 0.obs,
      ),
    );
  }

  void removeSubField(String key) {
    field?.value.subFields?.removeWhere((element) => element.key?.value == key);
  }
}
