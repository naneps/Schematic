import 'package:get/get.dart';
import 'package:schematic/app/models/user_gradient.model.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_editor_controller.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_tools_controller.dart';
import 'package:schematic/app/repositories/gradient_repository.dart';

class GradientTemplateController {
  final gradientRepo = Get.find<GradientRepository>();

  onUseGradient(UserGradientModel gradient) {
    Get.find<GradientEditorController>().gradient.value = gradient.gradient!;

    Get.find<GradientToolsController>().onGradientChanged(
      gradient.gradient!,
    );
  }
}
