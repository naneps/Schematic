import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/services/firebase/firebase_auth_service.dart';
import 'package:schematic/app/services/firebase/remote_config_service.dart';

class AuthController extends GetxController {
  final authService = Get.find<FirebaseAuthService>();
  final TextEditingController emailController = TextEditingController();
  final FirebaseRemoteConfigService rConfig =
      Get.find<FirebaseRemoteConfigService>();

  void signInAnonymously() {
    authService.signInAnonymously();
  }

  // Sign in with Email Link
  void signInWithEmailLink(String email) {
    authService.registerWithEmailOnly(email);
  }

  void signWithGitHub() {
    authService.signInWithGitHub();
  }
}
