import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/common/input/x_field.dart';
import 'package:schematic/app/modules/prompt/widgets/prompt_field.widget.dart';
import 'package:schematic/app/themes/theme.dart';

import '../controllers/prompt_controller.dart';

class PromptView extends GetView<PromptController> {
  const PromptView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            XTextField(
              labelText: "Prompt",
              hintText: "e.g generate dummy product",
              onChanged: (value) {
                controller.prompt.value.text = value;
              },
              prefixIcon: MdiIcons.formatListBulleted,
            ),
            const SizedBox(height: 10),
            Container(
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
                        IconButton(
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
                  Divider(
                    color: Colors.grey.shade200,
                  ),
                  Obx(() {
                    return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.prompt.value.fields?.length,
                      itemBuilder: (context, index) {
                        final field = controller.prompt.value.fields![index];
                        return PromptField(
                          index: index,
                          field: field,
                          key: const ValueKey("parent"),
                          onRemove: () {
                            controller.prompt.value.fields!.removeAt(index);
                            controller.prompt.refresh();
                          },
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeApp.primaryColor,
                fixedSize: Size(Get.width, 50),
                textStyle: Get.textTheme.labelMedium!,
              ),
              onPressed: () {},
              child: const Text("Generate"),
            ),
          ],
        ),
      ),
    );
  }
}
