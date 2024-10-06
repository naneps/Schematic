import 'package:get/get.dart';
import 'package:schematic/app/models/user_prompot.dart';
import 'package:schematic/app/modules/prompt/controllers/form_prompt_field.dart';
import 'package:schematic/app/repositories/prompt_repository.dart';

class SavedPromptController extends GetxController
    with StateMixin<List<UserPromptModel>> {
  RxList<UserPromptModel> prompts = <UserPromptModel>[].obs;
  final promptRepo = Get.find<PromptRepository>();
  final formPromptController = Get.find<FormPromptFieldController>();

  void deletePrompt(UserPromptModel prompt) {
    promptRepo.delete(prompt.id!);
    getPrompts();
  }

  void getPrompts() async {
    try {
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

  void loadPrompt(UserPromptModel prompt) async {
    try {
      formPromptController.prompt.value = prompt.prompt!;
      formPromptController.prompt.refresh();
    } on Exception catch (e) {
      // TODO
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
