import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/inputs/x_input.dart';
import 'package:schematic/app/modules/prompt/controllers/form_prompt_field.dart';
import 'package:schematic/app/modules/prompt/widgets/prompt_field.widget.dart';

class FormPromptField extends GetView<FormPromptFieldController> {
  const FormPromptField({
    super.key,
  });
  @override
  FormPromptFieldController get controller =>
      Get.put(FormPromptFieldController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.5,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          XInput(
            label: "Prompt",
            hintText: "e.g generate dummy product",
            onChanged: (value) {
              controller.prompt.value.text = value;
            },
            prefixIcon: const Icon(MdiIcons.formatListBulleted),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              constraints: BoxConstraints(maxHeight: Get.height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Text(
                          "Fields ${controller.prompt.value.allFieldKeyUnique}",
                          style: Get.textTheme.labelMedium,
                        ),
                        const Spacer(),
                        IconButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: ThemeManager().blackColor,
                            fixedSize: const Size(30, 30),
                          ),
                          onPressed: () {
                            controller.addField();
                          },
                          icon: const Icon(
                            MdiIcons.plus,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.prompt.value.fields?.length,
                        itemBuilder: (context, index) {
                          final field = controller.prompt.value.fields![index];
                          return PromptField(
                            field: field,
                            isValidated:
                                controller.prompt.value.allFieldKeyUnique,
                            key: ValueKey("parent${field.id}"),
                            onRemove: () {
                              controller.removeField(field.id);
                              controller.prompt.refresh();
                            },
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeManager().primaryColor,
              fixedSize: Size(Get.width, 50),
              textStyle: Get.textTheme.labelMedium!,
            ),
            onPressed: () {
              controller.generate();
            },
            child: const Text("Generate"),
          ),
        ],
      ),
    );
  }
}
