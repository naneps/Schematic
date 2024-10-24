import 'package:get/get.dart';
import 'package:schematic/app/modules/setting/controllers/apikey_controller.dart';
import 'package:schematic/app/repositories/apikey_repository.dart';

import '../controllers/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
    Get.lazyPut(() => ApiKeyController());
    Get.lazyPut(() => ApikeyRepository());
  }
}
