import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/commons/ui/logo.dart';
import 'package:schematic/app/commons/ui/responsive_layout.dart';
import 'package:schematic/app/modules/prompt/views/output_prompt_view.dart';
import 'package:schematic/app/modules/prompt/views/preview_prompt_view.dart';
import 'package:schematic/app/modules/prompt/views/prompt_view.dart';
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: IconButton.filled(
              onPressed: () async {
                await launchUrl(
                  Uri.parse('https://github.com/naneps/schematic'),
                  mode: LaunchMode.externalApplication,
                );
              },
              icon: const Icon(MdiIcons.github, size: 30),
            ),
          ),
        ],
      ),
      drawer: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [ThemeManager().defaultShadow()],
        ),
        child: Drawer(
          child: ListView(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: ThemeManager().blackColor, width: 2),
                  boxShadow: [
                    ThemeManager().defaultShadow(),
                  ],
                ),
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            controller.userService.user.value.avatar ??
                                'https://avatar.iran.liara.run/public',
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          controller.userService.user.value.name ?? 'Anonymous',
                          style: Get.textTheme.labelLarge,
                        ),
                        const SizedBox(height: 10),
                        // Text(controller.user.value.email),
                        // const SizedBox(height: 10),
                        // Text(controller.user.value.role),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: NeoButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeManager().errorColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Sign Out'),
                  onPressed: () => controller.signOut(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ResponsiveLayout(
        mobile: const PromptView(),
        tablet: Row(
          children: [
            const Expanded(
              child: PromptView(),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    ThemeManager().defaultShadow(),
                  ],
                  border: Border.all(
                    color: ThemeManager().blackColor,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerHeight: 0,
                        padding: EdgeInsets.zero,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ThemeManager().primaryColor,
                          boxShadow: [
                            ThemeManager().defaultShadow(),
                          ],
                        ),
                        tabs: [
                          Tab(
                            child: Text(
                              "Preview Prompt",
                              style: Get.textTheme.labelMedium,
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Output",
                              style: Get.textTheme.labelMedium,
                            ),
                          ),
                        ],
                        controller: controller.tabController,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabController,
                        children: [
                          PreviewPromptView(controller: controller),
                          OutputPromptView(controller: controller),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
