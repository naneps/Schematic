import 'package:get/get.dart';

import '../controllers/boxshadow_builder_controller.dart';

class BoxshadowBuilderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoxshadowBuilderController>(
      () => BoxshadowBuilderController(),
    );
  }
}
