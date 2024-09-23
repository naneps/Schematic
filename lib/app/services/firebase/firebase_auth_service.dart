import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/ui/overlays/laoding_dialog.dart';
import 'package:schematic/app/modules/auth/views/github_sign_view.dart';
import 'package:schematic/app/services/user_service.dart';

class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService userService = Get.find<UserService>();

  Future<void> registerWithEmailOnly(String email) async {
    try {
      LoadingDialog.show(Get.context!);
      final actionCodeSettings = ActionCodeSettings(
        url: 'https://your-app-url.com',
        handleCodeInApp: true,
        androidPackageName: 'com.example.app',
        androidInstallApp: true,
        androidMinimumVersion: '12',
        iOSBundleId: 'com.example.app',
      );

      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );

      Get.snackbar('Success', 'Verification email sent to $email');
    } catch (e) {
      Get.snackbar('Error', 'Failed to send email link: $e');
      print('Error sending email link: $e');
    } finally {
      LoadingDialog.hide(Get.context!);
    }
  }

  // Fungsi sign-in hanya menggunakan email link
  Future<void> signInWithEmailLink(String email, String emailLink) async {
    try {
      LoadingDialog.show(Get.context!);

      if (_auth.isSignInWithEmailLink(emailLink)) {
        final UserCredential userCredential = await _auth.signInWithEmailLink(
          email: email,
          emailLink: emailLink,
        );

        if (userCredential.user != null) {
          await userService.createUserInFirestore(userCredential.user!);
          Get.snackbar('Success', 'Logged in successfully');
        } else {
          Get.snackbar('Error', 'Failed to login');
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in: $e');
      print('Error signing in: $e');
    } finally {
      LoadingDialog.hide(Get.context!);
    }
  }

  // Fungsi sign-in anonymouse
  Future<void> signInAnonymously() async {
    try {
      LoadingDialog.show(Get.context!);
      final UserCredential userCredential = await _auth.signInAnonymously();

      if (userCredential.user != null) {
        await userService.createUserInFirestore(userCredential.user!);
        Get.snackbar('Success', 'Signed in anonymously');
      } else {
        Get.snackbar('Error', 'Failed to sign in anonymously');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in anonymously: $e');
      print('Error signing in anonymously: $e');
    } finally {
      LoadingDialog.hide(Get.context!);
    }
  }

  Future<Response> post(String url, Map<String, String> body) async {
    final response = await post(
      url,
      body,
    );

    return response;
  }

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
    String name, {
    VoidCallback? onFail,
    VoidCallback? onSuccess,
  }) async {
    try {
      LoadingDialog.show(Get.context!);
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await userService.createUserInFirestore(
          userCredential.user!,
          name: name,
        );
        userCredential.user!.sendEmailVerification();
        LoadingDialog.hide(Get.context!);
        if (onSuccess != null) {
          onSuccess();
        }
      } else {
        Get.snackbar('Error', 'Failed to register');
        if (onFail != null) {
          onFail();
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to register: $e');
      if (onFail != null) {
        onFail();
      }
      print('Error during registration: $e');
    } finally {
      LoadingDialog.hide(Get.context!);
    }
  }

  void sendEmailVerification() {
    final user = _auth.currentUser;
    if (user != null) {
      user.sendEmailVerification();
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Password reset email sent');
    } catch (e) {
      Get.snackbar('Error', 'Failed to send password reset email: $e');
      print('Error during password reset: $e');
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password, {
    VoidCallback? onSuccess,
    VoidCallback? onFail,
  }) async {
    try {
      LoadingDialog.show(Get.context!);
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        Get.snackbar('Success', 'Logged in successfully');
        await userService.createUserInFirestore(userCredential.user!);
        if (onSuccess != null) {
          Get.back();
          onSuccess();
        }
      } else {
        Get.snackbar('Error', 'Failed to login');
        if (onFail != null) {
          onFail();
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to login: $e');
      print('Error during login: $e');
    } finally {
      LoadingDialog.hide(Get.context!);
    }
  }

  Future<void> signInWithGitHub() async {
    try {
      print('Sign in with GitHub');
      if (kIsWeb) {
        final result = await _auth.signInWithPopup(GithubAuthProvider());
        if (result.user != null) {
          Get.snackbar('Success', 'Logged in successfully');
          await userService.createUserInFirestore(result.user!);
        } else {
          Get.snackbar('Error', 'Failed to login');
        }
      } else {
        // Mobile-specific code
        final result = await Get.dialog(
          const AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: GithubSignView(),
          ),
        );
        if (result == null || result is! String) {
          Get.snackbar('Error', 'Failed to get GitHub authorization code');
          return;
        }

        final clientID = dotenv.env['GITHUB_CLIENT_ID'];
        final clientSecret = dotenv.env['GITHUB_CLIENT_SECRET'];
        final response = await post(
          'https://github.com/login/oauth/access_token',
          {
            'client_id': clientID!,
            'client_secret': clientSecret!,
            'code': result,
          },
        );

        if (response.statusCode != 200) {
          Get.snackbar('Error',
              'Failed to exchange authorization code for access token');
          return;
        }

        final Map<String, dynamic> body = json.decode(response.body);
        final accessToken = body['access_token'];

        final AuthCredential credential =
            GithubAuthProvider.credential(accessToken);
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        if (userCredential.user != null) {
          Get.snackbar('Success', 'Logged in successfully');
          await userService.createUserInFirestore(userCredential.user!);
        } else {
          Get.snackbar('Error', 'Failed to login');
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to login: $e');
      print('Error during GitHub sign-in: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    userService.setUserOnlineStatus(false);
  }
}
