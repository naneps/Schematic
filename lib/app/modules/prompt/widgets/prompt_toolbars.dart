import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/commons/ui/overlays/x_snackbar.dart';
import 'package:schematic/app/modules/prompt/controllers/form_prompt_field.dart';

class PromptToolbars extends StatelessWidget {
  final FormPromptFieldController controller;

  const PromptToolbars({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Text(
            "Fields",
            style: Get.textTheme.labelMedium,
          ),
          const SizedBox(width: 10),
          const Spacer(),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              NeoButton(
                onPressed: () {
                  controller.addField();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeManager().infoColor,
                  textStyle: Get.textTheme.labelMedium!,
                ),
                child: const Text("Add Field"),
              ),
              const SizedBox(width: 10),
              NeoButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeManager().primaryColor),
                child: const Text("Generate Fields"),
                onPressed: () {
                  if (controller.prompt.value.text == "") {
                    XSnackBar.show(
                      context: context,
                      message: "fill prompt first",
                      type: SnackBarType.warning,
                    );
                    return;
                  }
                  controller.generateFields();
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
          NeoButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeManager().warningColor,
            ),
            child: const Text("Clear Fields"),
            onPressed: () {
              controller.clearFields();
            },
          ),
        ],
      ),
    );
  }
}
