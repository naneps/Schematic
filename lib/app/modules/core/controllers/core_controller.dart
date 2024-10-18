import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/models/navigation_model.dart';
import 'package:schematic/app/routes/app_pages.dart';
import 'package:schematic/app/services/user_service.dart';

class CoreController extends GetxController
    with GetSingleTickerProviderStateMixin {
  UserService userService = Get.find<UserService>();
  RxList<NavigationModel> navigation = RxList<NavigationModel>([]);
  RxInt currentIndex = 0.obs;

  late AnimationController animationController;

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    navigation.value = [
      NavigationModel(
        title: 'Data Generator',
        route: Routes.PROMPT,
        iconData: MdiIcons.fileDocumentOutline,
      ),
      NavigationModel(
        title: 'Tools',
        route: Routes.TOOLS,
        iconData: MdiIcons.tools,
      ),
      NavigationModel(
        title: 'Setting',
        // icon: 'assets/icons/home.svg',
        route: Routes.SETTING,
        iconData: MdiIcons.cogOutline,
      ),
    ];
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    userService.setUserOnlineStatus(false);
  }
}
