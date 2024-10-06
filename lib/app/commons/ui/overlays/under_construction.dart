import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_icon_button.dart';
import 'package:schematic/app/commons/ui/overlays/scale_dialog.dart';

class UnderConstruction extends StatelessWidget {
  const UnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      contentPadding: EdgeInsets.zero,
      content: ScaleDialog(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ThemeManager().primaryColor, width: 2),
            boxShadow: [
              ThemeManager().defaultShadow(
                color: ThemeManager().primaryColor,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NeoIconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(0),
                      side: BorderSide(color: ThemeManager().blackColor),
                    ),
                    icon: Icon(MdiIcons.close),
                  ),
                ],
              ),
              Image.asset(
                'assets/images/barrier.png',
                scale: 3,
              ),
              const SizedBox(height: 20),
              Text(
                'Coming Soon',
                style: Get.textTheme.labelMedium!.copyWith(
                  color: ThemeManager().blackColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
