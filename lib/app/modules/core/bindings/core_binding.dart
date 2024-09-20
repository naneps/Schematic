import 'package:get/get.dart';
import 'package:schematic/app/services/firebase/crashlytics_service.dart';
import 'package:schematic/app/services/firebase/firebase_auth_service.dart';
import 'package:schematic/app/services/user_service.dart';

import '../controllers/core_controller.dart';

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoreController>(() => CoreController());
    Get.lazyPut(() => CrashlyticsService());
    Get.lazyPut(() => UserService());
    Get.lazyPut(() => FirebaseAuthService());
  }
}
