import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
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
                  icon: const Icon(
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
          Expanded(
            child: controller.obx(
              (prompts) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: prompts!.length,
                  itemBuilder: (context, index) {
                    final prompt = prompts[index];
                    return Container(
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
                      child: ListTile(
                        title: Text(prompt.title!),
                        subtitle: Text(prompt.prompt!.toPrompt()),
                        trailing: IconButton(
                          onPressed: () {
                            // controller.deletePrompt(prompt);
                          },
                          icon: const Icon(MdiIcons.delete),
                        ),
                      ),
                    );
                  },
                );
              },
              onLoading: const LoadingWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
