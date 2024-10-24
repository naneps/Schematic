import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/commons/ui/buttons/neo_icon_button.dart';
import 'package:schematic/app/commons/ui/inputs/x_input.dart';
import 'package:schematic/app/modules/setting/controllers/apikey_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class FormApiKeyView extends GetView<ApiKeyController> {
  const FormApiKeyView({super.key});

  @override
  get controller => Get.put(ApiKeyController());
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add API Key",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                NeoIconButton(
                  icon: Icon(MdiIcons.close, size: 20),
                  size: const Size(30, 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            const Divider(),
            // API Key Name Input
            XInput(
              label: "API Key Name",
              hintText: "e.g., Gemini Production Key",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "API Key Name is required";
                }
                return null;
              },
              onChanged: (value) {
                controller.apiKey.value.name = value;
              },
            ),
            const SizedBox(height: 16),
            // API Key Value Input
            XInput(
              label: "API Key",
              hintText: "Enter your API key here",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "API Key is required";
                }
                return null;
              },
              onChanged: (value) {
                controller.apiKey.value.keyValue = value;
              },
            ),
            const SizedBox(height: 16),
            Obx(() {
              return Row(
                children: [
                  Text(
                    "Is Default",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(),
                  ),
                  const Spacer(),
                  Switch(
                    value: controller.apiKey.value.isDefault!.value,
                    activeTrackColor: ThemeManager().primaryColor,
                    thumbColor: WidgetStatePropertyAll(
                      ThemeManager().blackColor,
                    ),
                    thumbIcon: WidgetStatePropertyAll(
                      Icon(
                        MdiIcons.check,
                        color: Colors.white,
                      ),
                    ),
                    onChanged: (value) {
                      controller.apiKey.value.isDefault!.value = value;
                      controller.apiKey.refresh();
                    },
                  ),
                ],
              );
            }),
            const Divider(),
            Text(
              "Don’t have an API key yet?",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              "Visit the GEMINI developer portal to create an account and generate your API key. Make sure to copy and securely store it.",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: NeoButton(
                child: const Text("Get API Key"),
                onPressed: () async {
                  const url = 'https://aistudio.google.com/app/apikey';
                  await launchUrl(Uri.parse(url));
                },
              ),
            ),
            const Divider(),
            // Buttons for Save/Cancel
            Row(
              children: [
                Expanded(
                  child: NeoButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeManager().successColor,
                    ),
                    child: const Text("Save API Key"),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        controller.storeApi();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: NeoButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeManager().errorColor,
                    ),
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
