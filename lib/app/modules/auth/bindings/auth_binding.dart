import 'package:get/get.dart';
import 'package:schematic/app/services/firebase/firebase_auth_service.dart';
import 'package:schematic/app/services/firebase/remote_config_service.dart';
import 'package:schematic/app/services/user_service.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut(() => UserService());
    Get.lazyPut(() => FirebaseAuthService());
    Get.lazyPut(() => FirebaseRemoteConfigService());
  }
}
