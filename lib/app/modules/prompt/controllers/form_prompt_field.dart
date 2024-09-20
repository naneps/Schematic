import 'package:get/get.dart';
import 'package:schematic/app/enums/type_field.enum.dart';
import 'package:schematic/app/models/field.model.dart';
import 'package:schematic/app/models/promp.model.dart';
import 'package:schematic/app/services/google_generative_service.dart';

class FormPromptFieldController extends GetxController {
  final generativeService = Get.find<GoogleGenerativeService>();
  RxString output = ''.obs;
  RxBool isLoading = false.obs;
  Rx<Prompt> prompt = Prompt(
    text: 'data product camera',
    fields: [
      Field(
        key: 'name'.obs,
        type: FieldType.string.obs,
        subType: FieldType.string.obs,
        subFields: RxList<Field>([]),
      ),
      Field(
        key: 'description'.obs,
        type: FieldType.string.obs,
        subType: FieldType.string.obs,
        subFields: RxList<Field>([]),
      ),
      Field(
        key: 'model'.obs,
        type: FieldType.string.obs,
        subType: FieldType.string.obs,
        subFields: RxList<Field>([]),
      ),
      Field(
        key: 'images'.obs,
        type: FieldType.array.obs,
        subType: FieldType.string.obs,
        subFields: RxList<Field>([]),
      ),
      Field(
        key: 'specification'.obs,
        type: FieldType.object.obs,
        subType: FieldType.string.obs,
        description: ''.obs,
        subFields: [
          Field(
            key: 'brand'.obs,
            type: FieldType.string.obs,
            subType: FieldType.string.obs,
            subFields: RxList<Field>([]),
          ),
          Field(
            key: 'color'.obs,
            type: FieldType.string.obs,
            subType: FieldType.string.obs,
            subFields: RxList<Field>([]),
          ),
          Field(
            key: 'size'.obs,
            type: FieldType.string.obs,
            subType: FieldType.string.obs,
            subFields: RxList<Field>([]),
          ),
          Field(
            key: 'weight'.obs,
            type: FieldType.string.obs,
            subType: FieldType.string.obs,
            subFields: RxList<Field>([]),
          ),
        ].obs,
      )
    ].obs,
  ).obs;

  // Add a field
  void addField() {
    prompt.value.fields?.add(Field(
      key: ''.obs,
      type: FieldType.string.obs,
      subType: FieldType.string.obs,
      subFields: RxList<Field>([]),
    ));
    prompt.refresh();
  }

  // Add sample film structure
  void addFilmStructure() {
    prompt.value.fields?.addAll([
      Field(key: 'title'.obs, type: FieldType.string.obs),
      Field(key: 'genre'.obs, type: FieldType.string.obs),
      Field(key: 'releaseYear'.obs, type: FieldType.number.obs),
      Field(key: 'director'.obs, type: FieldType.string.obs),
      Field(
        key: 'cast'.obs,
        subFields: [
          Field(key: 'name'.obs, type: FieldType.string.obs),
        ].obs,
      ),
    ]);
    prompt.refresh();
  }

  // Add sample product structure
  void addProductStructure() {
    prompt.value.fields?.addAll([
      Field(key: 'name'.obs, type: FieldType.string.obs), // Product Name
      Field(key: 'price'.obs, type: FieldType.number.obs), // Product Price
      Field(
        key: 'category'.obs,
        subFields: [
          Field(key: 'id'.obs, type: FieldType.string.obs),
          Field(key: 'name'.obs, type: FieldType.string.obs),
        ].obs,
      ),
      Field(
        key: 'description'.obs,
        type: FieldType.string.obs,
      ), // Product Description
      Field(
        key: 'availability'.obs,
        type: FieldType.string.obs,
      ), // Availability status
    ]);
    prompt.refresh();
  }

  void generate() async {
    await generativeService.setPrompt(prompt.value.toPrompt());
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    output.bindStream(generativeService.output.stream);
    isLoading.bindStream(generativeService.isLoading.stream);
  }

  // Remove a field by ID
  void removeField(String id) {
    prompt.value.removeField(id);
    prompt.refresh();
  }
}
