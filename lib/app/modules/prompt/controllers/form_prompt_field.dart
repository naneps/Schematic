import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/enums/type_field.enum.dart';
import 'package:schematic/app/models/field.model.dart';
import 'package:schematic/app/models/promp.model.dart';
import 'package:schematic/app/models/user_prompot.dart';
import 'package:schematic/app/repositories/prompt_repository.dart';
import 'package:schematic/app/services/google_generative_service.dart';
import 'package:schematic/app/services/user_service.dart';

class FormPromptFieldController extends GetxController {
  final generativeService = Get.find<GoogleGenerativeService>();
  final promptRepo = Get.find<PromptRepository>();
  UserPromptModel? userPrompt = UserPromptModel(
    title: "Title",
    prompt: Prompt(
      text: "example",
      fields: <Field>[].obs,
    ),
    userId: "example",
  );
  RxString output = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isEnhancing = false.obs;
  RxBool isGeneratingFields = false.obs;
  Rx<Prompt> prompt = Prompt(
    text: 'Data Article ',
    fields: <Field>[].obs,
  ).obs;

  TextEditingController textPromptController = TextEditingController();

  void addField() {
    prompt.value.fields?.add(Field(
      key: ''.obs,
      type: FieldType.string.obs,
      subType: FieldType.string.obs,
      subFields: RxList<Field>([]),
      description: ''.obs,
      count: 0.obs,
    ));
    prompt.refresh();
  }

  // Add sample film structure
  void addFilmStructure() {
    prompt.value.fields?.addAll([
      Field(
        key: 'title'.obs,
        type: FieldType.string.obs,
        description: ''.obs,
      ),
      Field(
        key: 'genre'.obs,
        type: FieldType.string.obs,
        description: ''.obs,
      ),
      Field(
        key: 'releaseYear'.obs,
        description: ''.obs,
        type: FieldType.number.obs,
      ),
      Field(
        description: ''.obs,
        key: 'director'.obs,
        type: FieldType.string.obs,
      ),
      Field(
        key: 'cast'.obs,
        description: ''.obs,
        subFields: [
          Field(
            description: ''.obs,
            key: 'name'.obs,
            type: FieldType.string.obs,
          ),
        ].obs,
      ),
    ]);
    prompt.refresh();
  }

  void clearFields() {
    prompt.value.fields?.clear();
  }

  void enhancePrompt() async {
    isEnhancing.value = true;
    await generativeService.enhancePrompt(prompt.value.text!).then((value) {
      prompt.value.text = value;
      textPromptController.text = value;
      prompt.refresh();
    });
    isEnhancing.value = false;
  }

  Future<void> generate() async {
    try {
      isLoading.value = true;
      await generativeService.generateData(prompt.value.toPrompt()).then(
        (value) {
          output.value = value;
        },
      );
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void generateFields() async {
    isGeneratingFields.value = true;
    try {
      final value = await generativeService.generateFields(prompt.value.text!);
      print('Generated fields: $value');
      final Map<String, dynamic> jsonResponse = json.decode(value);
      final generatedFields = parseGeneratedFields(jsonResponse);
      prompt.value.fields?.clear();
      prompt.value.fields
          ?.addAll(generatedFields); // Add generated fields to prompt
      prompt.refresh(); // Refresh the prompt to update the UI
    } catch (e) {
      print("Error generating fields: $e"); // Handle error appropriately
    } finally {
      isGeneratingFields.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    textPromptController.text = prompt.value.text!;
  }

  List<Field> parseGeneratedFields(Map<String, dynamic> jsonResponse) {
    if (jsonResponse['success'] == true) {
      print("Successfully generated fields: ${jsonResponse['data']}");
      final data = jsonResponse['data'];
      if (data != null && data is List) {
        return data.map<Field>((fieldData) {
          if (fieldData == null) {
            throw Exception("Received null field data");
          }
          return Field.fromJson(fieldData);
        }).toList();
      } else {
        throw Exception(
            "Expected 'data' to be a List but got: ${data.runtimeType}");
      }
    } else {
      throw Exception("Failed to generate fields: ${jsonResponse['message']}");
    }
  }

  void removeField(String id) {
    prompt.value.removeField(id);
    prompt.refresh();
  }

  void savePrompt() async {
    if (isLoading.value) return;
    isLoading.value = true;
    userPrompt!.userId = Get.find<UserService>().user.value.uid;
    userPrompt!.prompt = prompt.value;
    await promptRepo.create(userPrompt!);
    isLoading.value = false;
  }
}
