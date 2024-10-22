import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/commons/ui/overlays/scale_dialog.dart';
import 'package:schematic/app/modules/setting/controllers/apikey_controller.dart';
import 'package:schematic/app/modules/setting/views/form_apikey_view.dart';
import 'package:schematic/app/modules/setting/widgets/apikey_tile.dart';

class ApikeyListView extends GetView<ApiKeyController> {
  const ApikeyListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: ThemeManager().defaultBorder(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              "Manage Your API Keys",
              style: Get.textTheme.headlineSmall,
            ),
            subtitle: const Text(
                "Add, edit, or remove your GEMINI API keys to generate data for your web projects."),
            trailing: NeoButton(
              child: const Text("Add API Key"),
              onPressed: () {
                showFormCreate();
              },
            ),
            contentPadding: EdgeInsets.zero,
          ),
          const Divider(),
          Text.rich(
            TextSpan(
              text: "Your API Keys",
              style: Get.textTheme.headlineSmall,
              children: [
                TextSpan(
                  text: " (${controller.apiKeys.length})",
                  style: Get.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: controller.obx(
              (context) {
                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: controller.apiKeys.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final apiKey = controller.apiKeys[index];
                    return ApikeyTile(
                      apiKey: apiKey,
                      controller: controller,
                      key: Key(apiKey.id!),
                    );
                  },
                );
              },
              onError: (error) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      error.toString(),
                      style: Get.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        controller.readAll();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                );
              },
              onEmpty: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("No API Keys found", style: Get.textTheme.bodyMedium),
                    RotatedBox(
                      quarterTurns: 0,
                      child: Icon(
                        MdiIcons.keyOutline,
                        size: 90,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showFormCreate() {
    Get.dialog(
      const ScaleDialog(
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          elevation: 0,
          content: FormApiKeyView(),
        ),
      ),
    );
  }
}
