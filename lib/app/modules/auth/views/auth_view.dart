import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app//modules/auth/widgets/form_signIn.dart';
import 'package:schematic/app/commons/theme_manager.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ThemeManager().blackColor,
                      width: 2,
                    ),
                  ),
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                    ThemeManager().primaryColor,
                    ThemeManager().secondaryColor
                  ])),
              height: Get.height,
              width: Get.width,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FormSignIn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
