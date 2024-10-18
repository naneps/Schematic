import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/ui/custom_drawer.dart';
import 'package:schematic/app/commons/ui/logo.dart';
import 'package:schematic/app/modules/prompt/views/prompt_view.dart';
import 'package:schematic/app/modules/prompt/views/saved_prompt_view.dart';
import 'package:schematic/app/modules/setting/views/setting_view.dart';
import 'package:schematic/app/modules/tools/views/tools_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/core_controller.dart';

class CoreView extends GetView<CoreController> {
  const CoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Logo(
          fontSize: 16,
        ),
        centerTitle: true,
        actions: [
          //setting
          IconButton(
            onPressed: () {
              Get.dialog(
                const AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.all(20),
                  content: SaveDPrompts(),
                ),
              );
            },
            icon: Icon(MdiIcons.cogOutline, size: 30),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: IconButton.filled(
              onPressed: () async {
                await launchUrl(
                  Uri.parse('https://github.com/naneps/schematic'),
                  mode: LaunchMode.externalApplication,
                );
              },
              icon: Icon(MdiIcons.github, size: 30),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(controller: controller),
      body: Obx(() {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                      .animate(animation),
              child: child,
            );
          },
          layoutBuilder: (currentChild, previousChildren) {
            return Stack(
              children: [
                if (currentChild != null) currentChild,
                ...previousChildren,
              ],
            );
          },
          reverseDuration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: IndexedStack(
            key: ValueKey<int>(controller.currentIndex.value),
            index: controller.currentIndex.value,
            children: const [
              PromptView(),
              ToolsView(),
              SettingView(),
            ],
          ),
        );
      }),
    );
  }
}
