import 'package:get/get.dart';
import 'package:schematic/app/models/promp.model.dart';

class PromptController extends GetxController {
  Rx<Prompt> prompt = Prompt(
    text: '',
    fields: [
      Field(
        key: 'name',
        type: FieldType.string,
      ),
    ],
  ).obs;

  void addField() {
    prompt.value.fields?.add(Field(
      key: '',
      type: FieldType.string,
    ));
    prompt.refresh();
  }
}
