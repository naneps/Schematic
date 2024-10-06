import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/commons/ui/buttons/neo_icon_button.dart';
import 'package:schematic/app/commons/ui/loading.widget.dart';
import 'package:schematic/app/modules/prompt/controllers/saved_prompt_controller.dart';

class SaveDPrompts extends GetView<SavedPromptController> {
  const SaveDPrompts({super.key});

  @override
  get controller => Get.put(SavedPromptController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.5,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ThemeManager().scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ThemeManager().primaryColor, width: 2),
        boxShadow: [
          ThemeManager().defaultShadow(
            color: ThemeManager().primaryColor,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Saved Prompts",
                style: Get.textTheme.labelLarge,
              ),
              const Spacer(),
              SizedBox(
                width: 30,
                child: NeoIconButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeManager().errorColor,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(0),
                    side: BorderSide(color: ThemeManager().blackColor),
                    foregroundColor: ThemeManager().scaffoldBackgroundColor,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    MdiIcons.close,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: ThemeManager().primaryColor,
            thickness: 2,
          ),
          //   maks data 10 / 10
          const Text("0 / 10"),
          const SizedBox(height: 10),
          Expanded(
            child: controller.obx(
              (prompts) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    // childAspectRatio: 3 / 2,
                  ),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: prompts!.length,
                  itemBuilder: (context, index) {
                    final prompt = prompts[index];
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ThemeManager().scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ThemeManager().primaryColor,
                          width: 1,
                        ),
                        boxShadow: [
                          ThemeManager().defaultShadow(
                            color: ThemeManager().primaryColor,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            prompt.title ?? 'Untitled',
                            style: Get.textTheme.labelLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            prompt.prompt!.text ?? 'No prompt found',
                            style: Get.textTheme.bodyLarge,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          const Spacer(),
                          SizedBox(
                            height: 40,
                            child: Row(
                              children: [
                                Expanded(
                                  child: NeoButton(
                                    child: const Text("Load"),
                                    onPressed: () {
                                      Get.back();
                                      controller.loadPrompt(prompt);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // close
                                NeoIconButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ThemeManager().errorColor,
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(0),
                                    fixedSize: const Size(30, 30),
                                    side: BorderSide(
                                        color: ThemeManager().blackColor),
                                    foregroundColor:
                                        ThemeManager().scaffoldBackgroundColor,
                                  ),
                                  onPressed: () {
                                    controller.deletePrompt(prompt);
                                  },
                                  icon: Icon(
                                    MdiIcons.trashCan,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              onLoading: const LoadingWidget(),
              onEmpty: const Center(
                child: Text("No Saved Prompts"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
