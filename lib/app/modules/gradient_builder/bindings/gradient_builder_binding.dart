import 'package:get/get.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_editor_controller.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_tools_controller.dart';

import '../controllers/gradient_builder_controller.dart';

class GradientBuilderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GradientBuilderController());
    Get.lazyPut(() => GradientToolsController());
    Get.lazyPut(() => GradientEditorController());
  }
}
