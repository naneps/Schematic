import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/enums/type_field.enum.dart';
import 'package:schematic/app/models/field.model.dart';
import 'package:schematic/app/models/promp.model.dart';
import 'package:schematic/app/services/google_generative_service.dart';

class FormPromptFieldController extends GetxController {
  final generativeService = Get.find<GoogleGenerativeService>();
  RxString output = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isEnhancing = false.obs;
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

  TextEditingController textPromptController = TextEditingController();

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

  // Remove a field by ID
  void generateFields() async {
    isLoading.value = true; // Set loading state to true
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
      isLoading.value = false; // Set loading state to false after completion
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
          // Debug output for each fieldData
          print("Processing field data: $fieldData");
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
}
