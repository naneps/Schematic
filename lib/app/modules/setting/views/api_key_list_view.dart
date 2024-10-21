import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/commons/ui/overlays/scale_dialog.dart';
import 'package:schematic/app/modules/setting/controllers/setting_controller.dart';
import 'package:schematic/app/modules/setting/views/form_apikey_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ApikeyListView extends StatelessWidget {
  final SettingController controller;

  const ApikeyListView({
    super.key,
    required this.controller,
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
          // Instructions on how to obtain the API key
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "To obtain your GEMINI API key, visit the GEMINI developer portal, create an account, and generate your API key. Make sure to keep it secure!",
              style: Get.textTheme.bodyMedium,
            ),
          ),
          // Button for more information
          Align(
            alignment: Alignment.centerRight,
            child: NeoButton(
              child: const Text("Learn More"),
              onPressed: () async {
                const url = 'https://aistudio.google.com/app/apikey';
                await launchUrl(Uri.parse(url));
              },
            ),
          ),
          const Divider(),
          // Existing API keys
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.apiKeys.length,
              itemBuilder: (context, index) {
                final apiKey = controller.apiKeys[index];
                return ListTile(
                  title: Text("API Key ${index + 1}",
                      style: Theme.of(context).textTheme.labelMedium),
                  subtitle: Text(apiKey.keyValue),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (apiKey.isDefault)
                        Chip(
                          label: const Text("Default"),
                          backgroundColor: Colors.green[200],
                        ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Edit API key action
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Delete API key action
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    controller.setDefaultApiKey(index);
                  },
                  contentPadding: EdgeInsets.zero,
                );
              },
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
