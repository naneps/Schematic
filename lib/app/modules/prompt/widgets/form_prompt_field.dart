import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/commons/ui/buttons/neo_icon_button.dart';
import 'package:schematic/app/commons/ui/inputs/x_input.dart';
import 'package:schematic/app/commons/ui/loading.widget.dart';
import 'package:schematic/app/commons/ui/overlays/scale_dialog.dart';
import 'package:schematic/app/commons/ui/overlays/x_snackbar.dart';
import 'package:schematic/app/modules/core/controllers/core_controller.dart';
import 'package:schematic/app/modules/prompt/controllers/form_prompt_field.dart';
import 'package:schematic/app/modules/prompt/views/saved_prompt_view.dart';
import 'package:schematic/app/modules/prompt/widgets/prompt_field.widget.dart';
import 'package:schematic/app/modules/prompt/widgets/prompt_toolbars.dart';

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
        horizontal: 15,
        vertical: 5,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "Prompt",
                style: Get.textTheme.headlineSmall,
              ),
              const Spacer(),
              //   help
              SizedBox(
                width: 40,
                height: 40,
                child: NeoIconButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeManager().primaryColor,
                    padding: EdgeInsets.zero,
                    foregroundColor: ThemeManager().blackColor,
                    shape: const CircleBorder(),
                    side: BorderSide(
                      color: ThemeManager().blackColor,
                      width: 2,
                    ),
                  ),
                  icon: Icon(
                    MdiIcons.helpCircle,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Obx(() {
                  return XInput(
                    label: "Prompt",
                    controller: controller.textPromptController,
                    hintText: "e.g generate product data",
                    minLines: 3,
                    maxLines: 5,
                    suffixIcon: controller.isEnhancing.value
                        ? Column(
                            children: [
                              LoadingAnimationWidget.hexagonDots(
                                color: ThemeManager().primaryColor,
                                size: 30,
                              ),
                              const SizedBox(height: 5),
                              AnimatedTextKit(
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    "Optimizing...",
                                    textStyle: Get.textTheme.labelMedium,
                                    speed: const Duration(milliseconds: 100),
                                  ),
                                ],
                                repeatForever: true,
                              )
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
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 40,
                      child: NeoButton(
                        onPressed: () {
                          if (controller.prompt.value.text == "") {
                            XSnackBar.show(
                              context: context,
                              message: "Prompt cannot be empty",
                              type: SnackBarType.error,
                            );
                            return;
                          }
                          controller.enhancePrompt();
                        },
                        child: const Text(
                          "Optimize Prompt",
                        ),
                      ),
                    ),
                    //   load from saved prompt
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      child: NeoButton(
                        onPressed: () {
                          Get.dialog(
                            const ScaleDialog(
                              child: AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                insetPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: ScaleDialog(
                                  child: SaveDPrompts(),
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Load Prompt",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              constraints: BoxConstraints(maxHeight: Get.height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PromptToolbars(controller: controller),
                  const SizedBox(height: 15),
                  Obx(() {
                    return Expanded(
                      child: controller.isGeneratingFields.value
                          ? const LoadingWidget(
                              text: ["Generating Fields...", "Please wait..."],
                            )
                          : controller.prompt.value.fields!.isEmpty
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "No fields added yet. Add some fields to get started.",
                                        style: Get.textTheme.bodySmall,
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: 30,
                                        child: NeoButton(
                                          child: const Text("Add Field"),
                                          onPressed: () {
                                            controller.addField();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      controller.prompt.value.fields?.length,
                                  itemBuilder: (context, index) {
                                    final field =
                                        controller.prompt.value.fields![index];
                                    return Obx(
                                      () {
                                        return PromptField(
                                          field: field,
                                          index: index,
                                          alReadyUsedKeys: [
                                            ...controller.prompt.value.fields!
                                                .map((e) => e.key!.value),
                                          ],
                                          isValidated: controller.prompt.value
                                              .allFieldKeyUnique.obs,
                                          key: ValueKey("parent${field.id}"),
                                          onRemove: () {
                                            controller.removeField(field.id);
                                            controller.prompt.refresh();
                                          },
                                        );
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
          const SizedBox(height: 15),
          Obx(() {
            return Row(
              children: [
                Expanded(
                  child: NeoButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeManager().warningColor,
                      fixedSize: Size(Get.width, 50),
                      textStyle: Get.textTheme.labelMedium!,
                    ),
                    onPressed: () {
                      controller.savePrompt();
                    },
                    child: const Text("Save Prompt"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: NeoButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeManager().primaryColor,
                      fixedSize: Size(Get.width, 50),
                      textStyle: Get.textTheme.labelMedium!,
                    ),
                    onPressed: () async {
                      if (cantGenerateIf()) {
                        XSnackBar.show(
                          context: context,
                          message: "Please fill prompt and add fields first",
                          type: SnackBarType.warning,
                        );
                        return;
                      }
                      controller.generate();
                      Get.find<CoreController>().tabController!.animateTo(1);
                    },
                    child: controller.isLoading.value
                        ? LoadingAnimationWidget.staggeredDotsWave(
                            color: ThemeManager().blackColor,
                            size: 30,
                          )
                        : const Text("Generate"),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  bool cantGenerateIf() {
    return controller.isLoading.value ||
        controller.prompt.value.text == "" ||
        controller.prompt.value.fields!.isEmpty;
  }
}
