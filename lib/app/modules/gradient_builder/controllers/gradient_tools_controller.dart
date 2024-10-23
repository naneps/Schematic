import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/models/gradient.model.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_builder_controller.dart';

class GradientToolsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  void onGradientChanged(GradientModel gradient) {
    Get.find<GradientBuilderController>().onGradientChanged(gradient);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }
}
