import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_icon_button.dart';
import 'package:schematic/app/commons/ui/inputs/x_input.dart';

import '../controllers/tools_controller.dart';

class ToolsView extends GetView<ToolsController> {
  const ToolsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              //   vertical: 20,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: XInput(
                    label: 'Search',
                    hintText: 'Search tools',
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
                const SizedBox(width: 20),
                NeoIconButton(
                  icon: Icon(MdiIcons.magnify),
                ),
              ],
            ),
          ),
          GridView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: controller.tools.length,
            itemBuilder: (context, index) {
              final tool = controller.tools[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(tool.route!);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    border: Border.all(
                      color: index.isEven
                          ? ThemeManager().primaryColor
                          : ThemeManager().secondaryColor,
                      width: 2,
                    ),
                    boxShadow: [
                      ThemeManager().defaultShadow(
                        color: index.isEven
                            ? ThemeManager().primaryColor
                            : ThemeManager().secondaryColor,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(tool.iconData, size: 90),
                      Text(
                        tool.title!,
                        style: Get.textTheme.labelLarge!.copyWith(
                          color: index.isEven
                              ? ThemeManager().primaryColor
                              : ThemeManager().secondaryColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
          )
        ],
      ),
    ));
  }
}
