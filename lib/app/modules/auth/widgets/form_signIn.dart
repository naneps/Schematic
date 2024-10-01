import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/commons/ui/inputs/x_input.dart';
import 'package:schematic/app/commons/ui/logo.dart';
import 'package:schematic/app/modules/auth/controllers/auth_controller.dart';
import 'package:schematic/app/services/firebase/remote_config_keys.dart';

class FormSignIn extends GetView<AuthController> {
  const FormSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.isPhone ? Get.width : Get.width * 0.3,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ThemeManager().blackColor, width: 3),
        boxShadow: [
          ThemeManager().defaultShadow(),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                const Logo(),
                const SizedBox(height: 10),
                Text(
                  controller.rConfig
                      .getString(RemoteConfigKey.copyWriteFormLogin.key),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Sign in with Registered Email",
              style: Get.textTheme.labelSmall,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                flex: 9,
                child: XInput(
                  controller: controller.emailController,
                  label: "Email",
                  hintText: "e.g. 0k5uJ@example.com",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  prefixIcon: const Icon(FontAwesomeIcons.envelope),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: NeoButton(
                  onPressed: () {
                    // Call the controller method to sign in with email
                    if (controller.emailController.text.isNotEmpty) {
                      controller
                          .signInWithEmailLink(controller.emailController.text);
                    } else {
                      Get.snackbar("Error", "Please enter a valid email");
                    }
                  },
                  child: const Text("Sign In"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Expanded(
                child: Divider(),
              ),
              Text(
                " OR ",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const Expanded(
                child: Divider(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Opacity(
            opacity: 0.2,
            child: NeoButton.icon(
              icon: const Icon(FontAwesomeIcons.user),
              style: ElevatedButton.styleFrom(
                foregroundColor: ThemeManager().blackColor,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: null,
              label: const Text('Sign in Anonymously'),
            ),
          ),
          const SizedBox(height: 15),
          NeoButton.icon(
            icon: Icon(
              FontAwesomeIcons.github,
              color: ThemeManager().blackColor,
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: ThemeManager().blackColor,
              backgroundColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              // Call the GitHub sign in method
              controller.signWithGitHub();
            },
            label: const Text('Sign in with GitHub'),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Expanded(
                child: Divider(),
              ),
              Text(
                " don't have an account? ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Expanded(
                child: Divider(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          NeoButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: ThemeManager().blackColor,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              // Navigate to create account page
              // controller.navigateToSignUp();
            },
            child: const Text('Create Account'),
          ),
        ],
      ),
    );
  }
}
