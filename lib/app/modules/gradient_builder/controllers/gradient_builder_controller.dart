import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/models/builder_models/box_decoration_model.dart';
import 'package:schematic/app/models/builder_models/container_model.dart';
import 'package:schematic/app/models/builder_models/gradient.model.dart';
import 'package:schematic/app/models/user_gradient.model.dart';
import 'package:schematic/app/modules/container_builder/controllers/container_builder_controller.dart';
import 'package:schematic/app/repositories/gradient_repository.dart';

class GradientBuilderController extends GetxController {
  final gradientRepository = Get.find<GradientRepository>();
  Rx<ContainerModel> container = ContainerModel(
    width: RxDouble(300),
    height: RxDouble(300),
    decoration: BoxDecorationModel(
      color: Colors.red,
      gradient: null,
    ),
  ).obs;

  Future<Stream<List<UserGradientModel>>> getGradients() async {
    return gradientRepository.getUserGradients();
  }

  void onGradientChanged(GradientModel gradient) {
    container.value.decoration!.gradient = gradient;
    container.value.decoration!.color = null;
    container.refresh();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    ever(
      Get.find<ContainerBuilderController>().container,
      (newContainer) {
        container.update(
          (val) {
            val!.width!.value = newContainer.width!.value;
            val.height!.value = newContainer.height!.value;
          },
        );
      },
    );
  }
}
