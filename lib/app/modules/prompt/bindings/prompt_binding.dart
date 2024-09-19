import 'package:get/get.dart';
import 'package:schematic/app/services/google_generative_service.dart';

import '../controllers/prompt_controller.dart';

class PromptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PromptController>(
      () => PromptController(),
    );
    Get.lazyPut(() => GoogleGenerativeService());
  }
}
