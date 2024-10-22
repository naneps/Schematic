import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/models/navigation_model.dart';
import 'package:schematic/app/routes/app_pages.dart';

class ToolsController extends GetxController {
  //TODO: Implement ToolsController
  RxList<NavigationModel> tools = <NavigationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    tools.value = [
      NavigationModel(
        title: 'Gradient Builder',
        iconData: MdiIcons.gradientHorizontal,
        route: Routes.GRADIENT_BUILDER,
      ),
      NavigationModel(
        title: 'Shadows Builder',
        route: Routes.BOXSHADOW_BUILDER,
        iconData: MdiIcons.boxShadow,
      ),
    ];
  }
}
