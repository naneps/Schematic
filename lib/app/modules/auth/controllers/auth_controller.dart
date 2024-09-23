import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/services/firebase/firebase_auth_service.dart';

class AuthController extends GetxController {
  final authService = Get.find<FirebaseAuthService>();
  final TextEditingController emailController = TextEditingController();
  void signWithGitHub() {
    authService.signInWithGitHub();
  }

  // Sign in with Email Link
  void signInWithEmailLink(String email) {
    authService.registerWithEmailOnly(email);
  }

  // Sign in Anonymously
  void signInAnonymously() {
    authService.signInAnonymously();
  }
}
