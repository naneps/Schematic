import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/models/field.model.dart';
import 'package:schematic/app/models/promp.model.dart';
import 'package:schematic/app/modules/prompt/controllers/form_prompt_field.dart';
import 'package:schematic/app/services/google_generative_service.dart';

class CoreController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<Prompt> prompt = Prompt().obs;
  RxList<Field> fields = RxList<Field>([]);
  final generativeService = Get.find<GoogleGenerativeService>();
  RxBool isLoading = false.obs;
  TabController? tabController;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    prompt.bindStream(Get.find<FormPromptFieldController>().prompt.stream);
    isLoading.bindStream(generativeService.isLoading.stream);

    tabController = TabController(length: 2, vsync: this);
  }
}
