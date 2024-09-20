import 'package:get/get.dart';
import 'package:schematic/app/services/firebase/firebase_auth_service.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController
  final authService = Get.find<FirebaseAuthService>();

  void signWithGitHub() {
    authService.signInWithGitHub();
  }
}
