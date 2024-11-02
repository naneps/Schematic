import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/models/user_gradient.model.dart';
import 'package:schematic/app/repositories/gradient.repository.dart';

class GradientPublicController extends GetxController
    with StateMixin<List<UserGradientModel>> {
  final gradientRepo = Get.find<GradientRepository2>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  RxString search = ''.obs;
  RxString filterType = 'all'.obs;
  Rx<List<UserGradientModel>> gradients = Rx<List<UserGradientModel>>([]);
  Stream<List<UserGradientModel>> getGradients() {
    return gradientRepo.streamUserGradients();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    streamGradients();
    everAll(
      [],
      (callback) {
        streamGradients();
      },
    );
  }

  void streamGradients() {
    // Set filter to null if 'all', otherwise pass filterType value
    final filter =
        filterType.value == 'all' ? null.obs.value : filterType.value;
    gradientRepo.streamItems(filters: {
      'gradient_type': filter,
      'published': true,
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
