import 'package:get/get.dart';
import 'package:schematic/app/models/field.model.dart';
import 'package:schematic/app/models/promp.model.dart';
import 'package:schematic/app/modules/prompt/controllers/form_prompt_field.dart';

class CoreController extends GetxController {
  Rx<Prompt> prompt = Prompt().obs;
  RxList<Field> fields = RxList<Field>([]);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(Get.find<FormPromptFieldController>().prompt, (callback) {
      prompt.value = callback;
      fields.value = callback.fields!;
    });
  }
}
