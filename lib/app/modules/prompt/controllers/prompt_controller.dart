import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/models/field.model.dart';
import 'package:schematic/app/models/promp.model.dart';
import 'package:schematic/app/modules/prompt/controllers/form_prompt_field.dart';
import 'package:schematic/app/services/google_generative_service.dart';
import 'package:schematic/app/services/user_service.dart';

class PromptController extends GetxController with GetTickerProviderStateMixin {
  final generativeService = Get.find<GoogleGenerativeService>();
  Rx<Prompt> prompt = Prompt().obs;
  RxList<Field> fields = RxList<Field>([]);
  RxBool isLoading = false.obs;
  UserService userService = Get.find<UserService>();
  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    prompt.value = Get.find<FormPromptFieldController>().prompt.value;
    prompt.bindStream(Get.find<FormPromptFieldController>().prompt.stream);
    isLoading
        .bindStream(Get.find<FormPromptFieldController>().isLoading.stream);
    tabController = TabController(length: 2, vsync: this);
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    userService.setUserOnlineStatus(false);
  }
}
