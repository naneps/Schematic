import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/models/user_gradient.model.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_editor_controller.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_tools_controller.dart';
import 'package:schematic/app/repositories/gradient_repository.dart';

class GradientTemplateController {
  final gradientRepo = Get.find<GradientRepository>();
  final scaffoldMessenger = GlobalKey<ScaffoldMessengerState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  void onPublishGradient(UserGradientModel gradient) async {
    gradient.published = true;
    await gradientRepo.updateGradient(gradient.id!, {
      'published': gradient.published,
      'published_at': DateTime.now().toIso8601String(),
    }).then((value) {
      scaffoldMessenger.currentState!.showSnackBar(
        SnackBar(
          margin: const EdgeInsets.all(
            10,
          ),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: ThemeManager().successColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Text(
            'Gradient published',
            style: Get.textTheme.bodyMedium,
          ),
        ),
      );
    });
  }

  onRemoveGradient(UserGradientModel gradient) async {
    await gradientRepo.deleteGradient(gradient.id!).then((value) {
      scaffoldMessenger.currentState!.showSnackBar(
        SnackBar(
          margin: const EdgeInsets.all(
            10,
          ),
          duration: const Duration(
            seconds: 3,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: ThemeManager().successColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Text(
            'Gradient removed',
            style: Get.textTheme.bodyMedium,
          ),
        ),
      );
    });
  }

  onUseGradient(UserGradientModel gradient) {
    Get.find<GradientEditorController>().gradient.value = gradient.gradient!;
    Get.find<GradientToolsController>().onGradientChanged(gradient.gradient!);
  }
}
