import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/models/builder_models/gradient.model.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_builder_controller.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_editor_controller.dart';

class GradientToolsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxString code = ''.obs;
  void onGradientChanged(GradientModel gradient) {
    Get.find<GradientBuilderController>().onGradientChanged(gradient);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    ever(Get.find<GradientEditorController>().gradient, (newGradient) {
      code.value = newGradient.toCode();
    });
  }
}
