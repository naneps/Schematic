import 'package:get/get.dart';
import 'package:schematic/app/models/user_prompot.dart';
import 'package:schematic/app/repositories/prompt_repository.dart';

class SavedPromptController extends GetxController
    with StateMixin<List<UserPromptModel>> {
  RxList<UserPromptModel> prompts = <UserPromptModel>[].obs;
  final promptRepo = Get.find<PromptRepository>();

  void getPrompts() async {
    try {
      change([], status: RxStatus.loading());
      prompts.value = await promptRepo.readAll();
      if (prompts.isEmpty) {
        change(prompts, status: RxStatus.empty());
      } else {
        change(prompts, status: RxStatus.success());
      }
    } on Exception catch (e) {
      // TODO
      change(prompts, status: RxStatus.error(e.toString()));
      print(e);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPrompts();
  }
}
