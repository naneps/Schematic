import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/commons/ui/buttons/neo_icon_button.dart';
import 'package:schematic/app/commons/ui/inputs/x_input.dart';
import 'package:url_launcher/url_launcher.dart';

class FormApiKeyView extends StatelessWidget {
  const FormApiKeyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: MediaQuery.of(context).size.width * 0.4,
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
          const XInput(
            label: "API Key Name",
            hintText: "e.g., Gemini Production Key",
          ),
          const SizedBox(height: 16),
          // API Key Value Input
          const XInput(
            label: "API Key",
            hintText: "Enter your API key here",
          ),
          const SizedBox(height: 16),
          // Instructions on how to get API key
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
                    // Save API key action
                  },
                ),
              ),
              const SizedBox(
                width: 5,
              ),
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
    );
  }
}
