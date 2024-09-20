import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/inputs/x_input.dart';

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
                gradient: LinearGradient(
                  begin: const Alignment(-1, -1),
                  end: const Alignment(1, 0.75),
                  colors: [
                    ThemeManager().primaryColor,
                    ThemeManager().blackColor
                  ],
                  stops: null,
                  tileMode: TileMode.clamp,
                ),
              ),
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

class FormSignIn extends GetView<AuthController> {
  const FormSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.3,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ThemeManager().blackColor,
            blurRadius: 0,
            spreadRadius: 1.2098895318253613,
            offset: const Offset(2.8143082588111596, 4.2346133613887815),
            blurStyle: BlurStyle.normal,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                const Logo(),
                const SizedBox(height: 10),
                Text(
                  'AI-powered tool to instantly generate mock data. Create data seamlessly for your development, testing, or research needs.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Sign with Email Registered ",
              style: Get.textTheme.labelSmall,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Expanded(
                flex: 9,
                child: XInput(
                  label: "Email",
                  hintText: "e.g. 0k5uJ@example.com",
                  prefixIcon: Icon(FontAwesomeIcons.ethereum),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Sign in'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Expanded(
                child: Divider(),
              ),
              Text(
                " OR ",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const Expanded(
                child: Divider(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(FontAwesomeIcons.user),
            style: ElevatedButton.styleFrom(
              foregroundColor: ThemeManager().blackColor,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: BorderSide(
                color: ThemeManager().blackColor,
              ),
            ),
            onPressed: () {},
            label: const Text('Sign in Anonymously'),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(FontAwesomeIcons.github),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: ThemeManager().blackColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              controller.signWithGitHub();
            },
            label: const Text('Sign in with GitHub'),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Expanded(
                child: Divider(),
              ),
              Text(
                " don't have an account? ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Expanded(
                child: Divider(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: ThemeManager().blackColor,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              // Navigate to create account page
              //   controller.navigateToSignUp();
            },
            child: const Text('Create Account'),
          ),
        ],
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-0.29, -0.1),
          end: const Alignment(0.05, 0.02),
          colors: [
            ThemeManager().blackColor,
            ThemeManager().primaryColor,
          ],
          stops: const [0, 1],
          tileMode: TileMode.clamp,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          text: "",
          style: Get.textTheme.displayLarge!,
          children: [
            TextSpan(
              text: 'Sche',
              style: Get.textTheme.displayMedium!.copyWith(
                color: ThemeManager().primaryColor,
                height: 1.3,
                letterSpacing: 1.5,
              ),
            ),
            TextSpan(
              text: 'matic ',
              style: Get.textTheme.displayMedium!.copyWith(
                color: ThemeManager().blackColor,
                height: 1.3,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
