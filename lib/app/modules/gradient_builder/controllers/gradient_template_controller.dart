import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/ui/overlays/x_snackbar.dart';
import 'package:schematic/app/models/user_gradient.model.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_editor_controller.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_tools_controller.dart';
import 'package:schematic/app/repositories/gradient.repository.dart';

class GradientTemplateController extends GetxController
    with StateMixin<List<UserGradientModel>> {
  final gradientRepo2 = Get.find<GradientRepository2>();
  final scaffoldMessenger = GlobalKey<ScaffoldMessengerState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  RxList<UserGradientModel> gradients = RxList<UserGradientModel>([]);
  RxString filterType = 'all'.obs; // Changed to non-nullable RxString

  @override
  void onInit() {
    super.onInit();
    streamGradients();
    ever(filterType, (String? type) {});
  }

  void onPublishGradient(UserGradientModel gradient) async {
    gradient.published = true;
    await gradientRepo2.updateGradient(gradient.id!, {
      'published': gradient.published,
      'published_at': DateTime.now().toIso8601String(),
    }).then((value) {
      scaffoldMessenger.currentState?.showSnackBar(XSnackBar.xSnackBar(
        scaffoldMessenger.currentState!.context,
        type: SnackBarType.success,
        message: 'Gradient published successfully',
      ));
    });
  }

  onRemoveGradient(UserGradientModel gradient) async {
    await gradientRepo2.deleteGradient(gradient.id!).then((value) {
      scaffoldMessenger.currentState?.showSnackBar(
        XSnackBar.xSnackBar(
          scaffoldMessenger.currentState!.context,
          type: SnackBarType.success,
          message: 'Gradient removed successfully',
        ),
      );
    });
  }

  onUseGradient(UserGradientModel gradient) {
    Get.find<GradientEditorController>().gradient.value = gradient.gradient!;
    Get.find<GradientToolsController>().onGradientChanged(gradient.gradient!);
  }

  void resetFilter() {
    filterType.value = 'all';
    streamGradients();
  }

  streamGradients() {
    // Set filter to null if 'all', otherwise pass filterType value
    final filter =
        filterType.value == 'all' ? null.obs.value : filterType.value;
    gradientRepo2.streamUserGradients(filters: {
      'gradient_type': filter,
    }).listen(
      (event) {
        if (event.isNotEmpty) {
          gradients.value = event;
          change(event, status: RxStatus.success());
        } else {
          change(event, status: RxStatus.empty());
        }
      },
    );
  }
}
