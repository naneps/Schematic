import 'package:get/get.dart';

import '../controllers/container_builder_controller.dart';

class ContainerBuilderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContainerBuilderController>(
      () => ContainerBuilderController(),
    );
  }
}
