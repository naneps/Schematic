import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/commons/ui/inputs/x_input.dart';
import 'package:schematic/app/modules/core/controllers/core_controller.dart';
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
      width: context.isPhone ? Get.width : Get.width * 0.5,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: ThemeManager().blackColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          ThemeManager().defaultShadow(),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(() {
                  return XInput(
                    label: "Prompt",
                    controller: controller.textPromptController,
                    hintText: "e.g generate product data",
                    maxLines: 5,
                    suffixIcon: controller.isEnhancing.value
                        ? Column(
                            children: [
                              LoadingAnimationWidget.hexagonDots(
                                color: ThemeManager().blackColor,
                                size: 20,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Optimizing...",
                                style: Get.textTheme.bodyMedium!.copyWith(
                                  color: ThemeManager().blackColor,
                                ),
                              ),
                            ],
                          )
                        : null,
                    onChanged: (value) {
                      controller.prompt.value.text =
                          value; // Update the observable prompt
                      controller.textPromptController.text =
                          value; // Also update the controller
                      controller.prompt
                          .refresh(); // Make sure it triggers reactive UI updates
                    },
                    prefixIcon: Icon(
                      MdiIcons.textBoxMultipleOutline,
                      size: 20,
                      color: ThemeManager().blackColor,
                    ),
                  );
                }),
              ),
              const SizedBox(width: 10),
              NeoButton(
                onPressed: () {
                  if (controller.prompt.value.text == "") {
                    Get.snackbar(
                      "Error",
                      "Please enter a prompt",
                    );
                    return;
                  }
                  controller.enhancePrompt();
                },
                child: const Text(
                  "Optimize Prompt",
                ),
              ),
            ],
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
                          "Fields",
                          style: Get.textTheme.labelMedium,
                        ),
                        const Spacer(),
                        NeoButton(
                          onPressed: () {
                            controller.addField();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeManager().primaryColor,
                            textStyle: Get.textTheme.labelMedium!,
                          ),
                          child: const Text("Add Field"),
                        ),
                        const SizedBox(width: 10),
                        //generateField
                        NeoButton(
                          child: const Text("Generate Fields"),
                          onPressed: () {
                            controller.generateFields();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.prompt.value.fields?.length,
                        itemBuilder: (context, index) {
                          final field = controller.prompt.value.fields![index];
                          return Obx(() {
                            return PromptField(
                              field: field,
                              alReadyUsedKeys: [
                                ...controller.prompt.value.fields!
                                    .map((e) => e.key!.value),
                              ],
                              isValidated:
                                  controller.prompt.value.allFieldKeyUnique.obs,
                              key: ValueKey("parent${field.id}"),
                              onRemove: () {
                                controller.removeField(field.id);
                                controller.prompt.refresh();
                              },
                            );
                          });
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Obx(() {
            return NeoButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeManager().primaryColor,
                fixedSize: Size(Get.width, 50),
                textStyle: Get.textTheme.labelMedium!,
              ),
              onPressed: () async {
                if (controller.isLoading.value) return;
                controller.generate();
                Get.find<CoreController>().tabController!.animateTo(1);
              },
              child: controller.isLoading.value
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: ThemeManager().blackColor,
                      size: 30,
                    )
                  : const Text("Generate"),
            );
          }),
        ],
      ),
    );
  }
}
