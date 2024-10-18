import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/navigation_tile.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/modules/core/controllers/core_controller.dart';

class CustomDrawer extends StatelessWidget {
  final CoreController controller;

  const CustomDrawer({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [ThemeManager().defaultShadow()],
      ),
      child: Drawer(
        width: 250,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ThemeManager().blackColor, width: 2),
                boxShadow: [
                  ThemeManager().defaultShadow(),
                ],
              ),
              child: DrawerHeader(
                decoration: BoxDecoration(color: ThemeManager().primaryColor),
                child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: ThemeManager().backgroundColor,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                            controller.userService.user.value.avatar ??
                                'https://avatar.iran.liara.run/public',
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        controller.userService.user.value.name ?? 'Anonymous',
                        style: Get.textTheme.labelLarge!.copyWith(
                          color: ThemeManager().backgroundColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }),
              ),
            ),
            Obx(() {
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                shrinkWrap: true,
                itemCount: controller.navigation.length,
                itemBuilder: (context, index) {
                  final item = controller.navigation[index];
                  return Obx(() {
                    return NavigationTile(
                        item: item,
                        isActive: controller.currentIndex.value == index,
                        onTap: () {
                          Navigator.pop(context);
                          controller.currentIndex.value = index;
                        });
                  });
                },
              );
            }),
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
    );
  }
}
